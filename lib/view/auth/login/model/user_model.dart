import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;
  final String userMail;
  final String? userName;
  const UserModel(
      {required this.userId, required this.userMail, required this.userName});
}
