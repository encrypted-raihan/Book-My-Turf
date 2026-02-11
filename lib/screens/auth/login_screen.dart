import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/gradient_button.dart';
import '../../services/phone_auth_service.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    FocusScope.of(context).unfocus();
    final rawPhone = _phoneController.text.trim();
    final phoneNumber = rawPhone.startsWith('+') ? rawPhone : '+$rawPhone';

    if (phoneNumber.length < 10) {
      _showSnackBar('Enter a valid phone number with country code.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await PhoneAuthService.sendOtp(phoneNumber: phoneNumber);
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            phoneNumber: phoneNumber,
            verificationId: result.verificationId,
            confirmationResult: result.confirmationResult,
          ),
        ),
      );
    } on Exception catch (error) {
      _showSnackBar(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
                "Let's start\nwith your phone number",
                style: AppTextStyles.title.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 12),
              Text(
                'We’ll send you a verification code',
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Phone number (e.g. +91XXXXXXXXXX)',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Use E.164 format with country code for reliable OTP delivery.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const Spacer(),
              GradientButton(
                text: _isLoading ? 'Sending OTP...' : 'Continue',
                onTap: _isLoading ? () {} : _sendOtp,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
