import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutsModel {
  final int trainTime;
  final String trainType;
  final String id;

  const WorkoutsModel({
    required this.trainTime,
    required this.trainType,
    required this.id,
  });
  factory WorkoutsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return WorkoutsModel(
      trainTime: data?['time'] as int,
      trainType: data?['type'] as String,
      id: data?['id'] as String,
    );
  }
}
