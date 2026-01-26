import 'package:flutter/material.dart';
import '../../theme/gradients.dart';
import '../../theme/text_styles.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.primary,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 96,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Text(
                "Booking Confirmed",
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your slot is locked.\nGame on!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
