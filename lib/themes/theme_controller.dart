import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;

  get currentTheme => _currentTheme;

  toggleTheme(bool isDark) {
    _currentTheme = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  useSystemTheme() {
    _currentTheme = ThemeMode.system;
    notifyListeners();
  }
}
