import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode; // Inicializa con un valor predeterminado

  // Getters para saber si el tema es claro u oscuro
  bool get isLightMode => _themeData == lightMode;

  ThemeProvider() {
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLight = prefs.getBool('isLight') ??
        true; // Si no se encuentra la preferencia, se usa el tema claro por defecto
    _themeData = isLight ? lightMode : darkMode;
    notifyListeners();
  }

  get themeData => _themeData;

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_themeData == lightMode) {
      _themeData = darkMode;
      await prefs.setBool('isLight', false);
    } else {
      _themeData = lightMode;
      await prefs.setBool('isLight', true);
    }
    notifyListeners(); // Notifica a los widgets que estan escuchando
  }
}
