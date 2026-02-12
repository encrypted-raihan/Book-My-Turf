import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class OtpRequestResult {
  const OtpRequestResult({
    this.verificationId,
    this.resendToken,
    this.confirmationResult,
  });

  final String? verificationId;
  final int? resendToken;
  final ConfirmationResult? confirmationResult;
}

class PhoneAuthService {
  PhoneAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<OtpRequestResult> sendOtp({
    required String phoneNumber,
    int? forceResendingToken,
  }) async {
    if (kIsWeb) {
      final confirmation = await _auth.signInWithPhoneNumber(
        phoneNumber,
        RecaptchaVerifier(
          auth: _auth,
          container: 'recaptcha-container',
          size: RecaptchaVerifierSize.normal,
          theme: RecaptchaVerifierTheme.dark,
        ),
      );

      return OtpRequestResult(confirmationResult: confirmation);
    }

    final completer = Completer<OtpRequestResult>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        if (!completer.isCompleted) {
          completer.completeError(error);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (!completer.isCompleted) {
          completer.complete(
            OtpRequestResult(
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        }
      },
      codeAutoRetrievalTimeout: (_) {},
    );

    return completer.future;
  }

  static Future<UserCredential> verifyOtp({
    required String smsCode,
    String? verificationId,
    ConfirmationResult? confirmationResult,
  }) async {
    if (kIsWeb) {
      if (confirmationResult == null) {
        throw FirebaseAuthException(
          code: 'missing-confirmation',
          message: 'Missing web confirmation result for OTP verification.',
        );
      }
      return confirmationResult.confirm(smsCode);
    }

    if (verificationId == null || verificationId.isEmpty) {
      throw FirebaseAuthException(
        code: 'missing-verification-id',
        message: 'Missing verification ID for OTP verification.',
      );
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return _auth.signInWithCredential(credential);
  }
}
