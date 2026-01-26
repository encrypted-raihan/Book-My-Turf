import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7C5CFF), // muted purple
      Color(0xFF9A7BFF),
    ],
  );

  static const LinearGradient subtle = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A1A22),
      Color(0xFF0B0B0F),
    ],
  );
}
