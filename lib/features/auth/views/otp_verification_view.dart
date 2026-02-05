import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/features/auth/controllers/forgot_password_controller.dart';
import 'package:osoul_x_psm/features/auth/views/reset_password_view.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationView extends StatelessWidget {
  const OTPVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: enterOTP.tr,
      body: GetBuilder<ForgotPasswordController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VPadding(25),

              // Instruction Text
              Text(
                otpSentToEmail.tr,
                style: const TextStyle(fontSize: 14, color: Color(0xFF70747B)),
              ),

              const VPadding(32),

              // OTP Input using Pinput
              Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 4,
                    controller: controller.otpController,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF002544),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE6E9EC), width: 1),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF002544),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF68408C), width: 2),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF002544),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0ECF4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF68408C), width: 1),
                      ),
                    ),
                  ),
                ),
              ),

              const VPadding(50),

              // Proceed Button
              Center(
                child: controller.isLoadingSendTempPassword
                    ? MyProgressIndicator()
                    : MyGradientButton(
                        onPressed: () async {
                          await controller.sendTempPassword();
                        },
                        label: proceed.tr,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
