import 'package:flutter/material.dart';

//Modo claro y oscuro para la interfaz
final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 246, 246, 246),
    primary: Color.fromARGB(255, 228, 229, 241),
    secondary: Color.fromARGB(255, 165, 165, 165),
    surface: Color.fromARGB(255, 232, 240, 254),
    onTertiary: Color.fromARGB(255, 255, 255, 255),
    shadow: Color.fromARGB(255, 204, 237, 241),
    tertiary: Color.fromARGB(255, 0, 0, 0),
    primaryContainer: Color.fromARGB(255, 27, 58, 133),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 46, 45, 45),
    primary: Color.fromARGB(255, 66, 66, 66),
    secondary: Color.fromARGB(255, 97, 97, 97),
    surface: Color.fromARGB(255, 86, 113, 161),
    onTertiary: Color.fromARGB(255, 0, 0, 0),
    shadow: Color.fromARGB(255, 61, 117, 144),
    tertiary: Color.fromARGB(255, 255, 255, 255),
    primaryContainer: Color.fromARGB(255, 204, 237, 241),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
);
