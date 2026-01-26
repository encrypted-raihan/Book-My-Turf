import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const TurfApp());
}

class TurfApp extends StatelessWidget {
  const TurfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turf Booking',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Manrope',
      ),
      home: const LoginScreen(),
    );
  }
}
