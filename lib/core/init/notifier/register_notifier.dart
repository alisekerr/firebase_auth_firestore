import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier {
  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
