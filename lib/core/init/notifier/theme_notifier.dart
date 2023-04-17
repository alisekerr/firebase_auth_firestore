import 'package:flutter/material.dart';

import '../../constants/enums/app_theme_enums.dart';
import '../theme/app_theme_light.dart';

class ThemeNotifier extends ChangeNotifier {
  // # Instance erişim için get
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  // # LIGHT theme erişimi için get
  AppThemes _currenThemeEnum = AppThemes.LIGHT;
  AppThemes get currenThemeEnum => _currenThemeEnum;

  void changeValue(AppThemes theme) {
    // # State management ile theme arası geçiş istenmesi hali için hazırlanan value fonksiyonumuz
    if (theme == AppThemes.LIGHT) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }

  void changeTheme() {
    // # State management ile theme arası geçiş istenmesi hali için hazırlanan theme fonksiyonumuz
    if (_currenThemeEnum == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark();
      _currenThemeEnum = AppThemes.DARK;
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currenThemeEnum = AppThemes.LIGHT;
    }
    notifyListeners();
  }
}
