import 'package:flutter/material.dart';
import 'package:sgasu_movil/main_app.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
   HttpOverrides.global = MyHttpOverrides();

  runApp(const MainApp());
}