// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/gradients.dart';
import '../../theme/text_styles.dart';
import '../../widgets/gradient_button.dart';
import 'otp_screen.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Title
              Text(
                "Let's start\nwith your phone number",
                style: AppTextStyles.title.copyWith(fontSize: 26),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                "We’ll send you a verification code",
                style: AppTextStyles.body,
              ),

              const SizedBox(height: 40),

              // Phone input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const TextField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const Spacer(),

              // Gradient button
              GradientButton(
  text: "Continue",
  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const OtpScreen()),
  );
},

),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
