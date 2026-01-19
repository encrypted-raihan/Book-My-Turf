import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'constants/app_theme.dart';
import 'screens/main_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: AppTheme.darkTheme,
      home: const MainNavScreen(),
    );
  }
}
