import 'package:flutter/material.dart';

class AppTheme{

static const  fontprimarycolor =
     Color.fromARGB(223, 0, 0, 0);

static const fontsecondcolor =
Color.fromARGB(255, 58, 58, 58);

static const backcolor =
Color.fromARGB(255, 234, 245, 236);



static final ThemeData lightTheme= ThemeData.light().copyWith(
    scaffoldBackgroundColor: backcolor,
);

}