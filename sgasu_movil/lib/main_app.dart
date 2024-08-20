import 'package:flutter/material.dart';
import 'package:sgasu_movil/screens/home_screens.dart';
import 'package:sgasu_movil/theme/app_theme.dart';


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppTheme.lightTheme
    );
  }
}