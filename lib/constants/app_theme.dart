import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: kBackgroundColor,
    primaryColor: kPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: kTextColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
