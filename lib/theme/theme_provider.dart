import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
   
   // Getters para saber si el tema es claro u oscuro
  bool get isLightMode => _themeData == lightMode;

  ThemeProvider() : _themeData = lightMode {
    _themeData = lightMode; // Tema claro por defecto
  }

  get themeData => _themeData;

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners(); // Notifica a los widgets que estan escuchando
  }
}