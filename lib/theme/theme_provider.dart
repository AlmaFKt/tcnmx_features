import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'theme.dart'; // Import your theme.dart file

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider() : _themeData = lightMode {
    _themeData = lightMode; // Default theme
  }

  get themeData => _themeData;

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners(); // Notify listeners of theme change
  }
}