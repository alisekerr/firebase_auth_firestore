import 'package:bitely/core/init/abstracts/i_train_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../view/workouts/model/workouts_model.dart';

class TrainNotifier extends ChangeNotifier implements ITrainService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  List<WorkoutsModel> trainList = [];
  List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  String currentDay = "";

  // # Seçilen günün içerisindeki trains dataları getiren firebase bloğumuz
  @override
  Future<List<WorkoutsModel>> getDaysData(String day) async {
    var reference = await firestore
        .collection(_authInstance.currentUser!.uid)
        .doc(day)
        .collection(day)
        .get();
    final userData =
        reference.docs.map((e) => WorkoutsModel.fromSnapshot(e)).toList();

    trainList = userData;
    notifyListeners();
    return userData;
  }

  // # Seçilen train alanını silen bloğumuz
  @override
  Future<void> deleteTrain(String day, String id) async {
    await firestore
        .collection("${_authInstance.currentUser?.uid}")
        .doc(day)
        .collection(day)
        .doc(id)
        .delete();
    getDaysData(day);
  }

  // # Girilen değerler ile birlikte yeni train oluşturan bloğumuz
  @override
  Future<void> postTrain(
      {String? day, int? trainTime, String? trainType}) async {
    var docRef = firestore
        .collection("${_authInstance.currentUser?.uid}")
        .doc(day)
        .collection(day!)
        .doc();
    String docId = docRef.id;
    await docRef.set({"time": trainTime, "type": trainType, "id": docId});
    getDaysData(day);
  }

// # Girilen değerler ile birlikte var olan train üzerinde güncelleme yapan bloğumuz
  @override
  Future<void> updateTrain(
      {String? day, int? trainTime, String? trainType, String? id}) async {
    var docRef = firestore
        .collection("${_authInstance.currentUser?.uid}")
        .doc(day)
        .collection(day!)
        .doc(id);
    String docId = docRef.id;
    await docRef.update({"time": trainTime, "type": trainType, "id": docId});
    getDaysData(day);
  }
}
