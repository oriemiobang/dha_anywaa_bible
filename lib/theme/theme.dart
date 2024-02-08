import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.white38,
      secondary: Colors.grey),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 1, 10, 29),
      primary: Color.fromARGB(83, 58, 55, 55),
      secondary: Color.fromARGB(113, 75, 73, 73)),
);
