import 'package:flutter/material.dart';

class SplashNotifier with ChangeNotifier {
  double imageOpacity = 0;

  // # Splash Screende bulunan yazıyı animasyonlu gösterebilmek için
  void splashOpacityUp() {
    imageOpacity = 1;
    notifyListeners();
  }
}
