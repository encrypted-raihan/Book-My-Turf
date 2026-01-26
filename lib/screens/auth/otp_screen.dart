import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/gradient_button.dart';
import '../player/player_home_screen.dart';
import '../player/player_main_screen.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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

              Text(
                "Enter OTP",
                style: AppTextStyles.title.copyWith(fontSize: 26),
              ),

              const SizedBox(height: 12),

              Text(
                "We sent a code to your number",
                style: AppTextStyles.body,
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                  decoration: InputDecoration(
                    hintText: "••••",
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                  ),
                  maxLength: 4,
                ),
              ),

              const Spacer(),

              GradientButton(
                text: "Verify",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PlayerMainScreen(),
                    ),
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
