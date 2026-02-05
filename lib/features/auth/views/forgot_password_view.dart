import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/features/auth/controllers/forgot_password_controller.dart';
import 'package:osoul_x_psm/features/auth/views/otp_verification_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: forgotPasswordTitle.tr,
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VPadding(25),

              // Instruction Text
              Text(
                enterEmailToReset.tr,
                style: const TextStyle(fontSize: 14, color: Color(0xFF70747B)),
              ),

              const VPadding(16),

              // Email Field
              CustomTextFieldWidget(
                title: emailLabel.tr,
                hint: 'name@example.com',
                controller: controller.emailController,
                keyBoardType: TextInputType.emailAddress,
              ),

              const VPadding(50),

              // Proceed Button
              Center(
                child: controller.isLoadingForgotPassword
                    ? MyProgressIndicator()
                    : MyGradientButton(
                        onPressed: () async {
                          await controller.forgotPassword();
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
