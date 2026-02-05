import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/shared_widgets/snackbar.dart';
import 'package:osoul_x_psm/features/auth/views/login_view.dart';
import 'package:osoul_x_psm/features/auth/views/otp_verification_view.dart';
import 'package:osoul_x_psm/features/auth/views/reset_password_view.dart';

class ForgotPasswordController extends GetxController {
  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController tempPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // Obscure state
  bool isTempPasswordObscure = true;
  bool isNewPasswordObscure = true;

  // Loading states
  bool isLoadingForgotPassword = false;
  bool isLoadingSendTempPassword = false;
  bool isLoadingChangePassword = false;

  /// Step 1: Send OTP to email
  /// You will implement the actual API call in services
  Future<void> forgotPassword() async {
    isLoadingForgotPassword = true;
    update();

    Map<String, dynamic> body = {'email': emailController.text};
    bool response = await Services().forgetPasswordSendEmailOtp(body);

    if (response == true) {
      Get.to(() => const OTPVerificationView());
      showSnackBar('OTP has been sent to your email', type: SnackBarType.success);
    } else {
      showSnackBar('Try again', type: SnackBarType.failure);
    }

    isLoadingForgotPassword = false;
    update();
  }

  /// Step 2: Verify OTP and send temporary password
  /// You will implement the actual API call in services
  Future<void> sendTempPassword() async {
    isLoadingSendTempPassword = true;
    update();

    Map<String, dynamic> body = {'email': emailController.text, 'otp': otpController.text};
    bool response = await Services().forgetPasswordSendTempPassword(body);

    if (response == true) {
      Get.to(() => const ResetPasswordView());
      showSuccessDialog(description: tempPasswordSentTitle.tr);
    } else {
      showSnackBar(wrongOtpCode.tr, type: SnackBarType.failure);
    }

    isLoadingSendTempPassword = false;
    update();
  }

  /// Step 3: Change password using temp password
  /// You will implement the actual API call in services
  Future<void> changePasswordWithTemp() async {
    isLoadingChangePassword = true;
    update();

    Map<String, dynamic> body = {
      'email': emailController.text,
      'oldpassword': tempPasswordController.text,
      'newpassword': newPasswordController.text,
    };
    bool response = await Services().forgetPasswordChangePasswordWithTemp(body);

    if (response == true) {
      Get.offAll(() => const LoginView());
      showSuccessDialog(description: passwordChangedSuccessfully.tr);
    } else {
      showSnackBar(tryAgain.tr, type: SnackBarType.failure);
    }

    isLoadingChangePassword = false;
    update();
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    tempPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
