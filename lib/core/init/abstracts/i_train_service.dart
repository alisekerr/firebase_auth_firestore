import 'package:bitely/view/workouts/model/workouts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ITrainService {
  Future<List<WorkoutsModel>> getDaysData(String day);
  Future<void> deleteTrain(String day, String id);
  Future<void> postTrain({String day, int trainTime, String trainType});
  Future<void> updateTrain(
      {String day, int trainTime, String trainType, String id});
}
