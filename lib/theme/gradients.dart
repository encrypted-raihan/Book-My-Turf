import 'package:flutter/material.dart';
import 'colors.dart';

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.accent,
      AppColors.primary,
      AppColors.neonPink,
    ],
  );
}
