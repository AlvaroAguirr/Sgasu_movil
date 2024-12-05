import 'package:flutter/material.dart';

class AppTheme {
  static const fontprimarycolor = Color.fromARGB(223, 0, 0, 0);

  static const fontsecondcolor = Color.fromARGB(255, 58, 58, 58);

  static const backcolorGreen = Color.fromARGB(255, 186, 85, 211);

  static const whiteColor = Color.fromARGB(255, 254, 254, 254);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: whiteColor,
      appBarTheme: const AppBarTheme(
          color: backcolorGreen,
          titleTextStyle:
              TextStyle(color: fontprimarycolor, fontWeight: FontWeight.bold)));
}
