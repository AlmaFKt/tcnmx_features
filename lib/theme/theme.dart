import 'package:flutter/material.dart';

//Modo claro y oscuro para la interfaz
final ThemeData lightMode =ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 246, 246, 246),
    primary: Color.fromARGB(255, 228, 229, 241),
    secondary: Color.fromARGB(255, 204, 237, 241),
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
        background: Color.fromARGB(255, 33, 33, 33),
    primary: Color.fromARGB(255, 66, 66, 66),
    secondary: Color.fromARGB(255, 97, 97, 97),
  ),
);
