import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/phone_auth_service.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/gradient_button.dart';
import '../player/player_main_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    this.verificationId,
    this.confirmationResult,
  });

  final String phoneNumber;
  final String? verificationId;
  final ConfirmationResult? confirmationResult;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 6) {
      _showSnackBar('Please enter the 6-digit OTP.');
      return;
    }

    setState(() => _isVerifying = true);

    try {
      await PhoneAuthService.verifyOtp(
        smsCode: otp,
        verificationId: widget.verificationId,
        confirmationResult: widget.confirmationResult,
      );

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PlayerMainScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      _showSnackBar(error.message ?? 'OTP verification failed. Please try again.');
    } catch (_) {
      _showSnackBar('OTP verification failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

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
                'Enter OTP',
                style: AppTextStyles.title.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 12),
              Text(
                'We sent a code to ${widget.phoneNumber}',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                  decoration: const InputDecoration(
                    hintText: '••••••',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  maxLength: 6,
                ),
              ),
              const Spacer(),
              GradientButton(
                text: _isVerifying ? 'Verifying...' : 'Verify',
                onTap: _isVerifying ? () {} : _verifyOtp,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
