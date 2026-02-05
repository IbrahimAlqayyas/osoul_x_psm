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
import 'package:osoul_x_psm/features/auth/views/login_view.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: resetPasswordTitle.tr,
      body: GetBuilder<ForgotPasswordController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VPadding(25),

              // Instruction Text
              Text(
                enterTempPassword.tr,
                style: const TextStyle(fontSize: 14, color: Color(0xFF70747B)),
              ),

              const VPadding(16),

              // Temporary Password Field
              CustomTextFieldWidget(
                title: tempPassword.tr,
                hint: '********',
                controller: controller.tempPasswordController,
                isObscure: controller.isTempPasswordObscure,
                showObscureToggle: true,
              ),

              const VPadding(16),

              // New Password Field
              CustomTextFieldWidget(
                title: newPassword.tr,
                hint: '********',
                controller: controller.newPasswordController,
                isObscure: controller.isNewPasswordObscure,
                showObscureToggle: true,
              ),

              const VPadding(50),

              // Proceed Button
              Center(
                child: controller.isLoadingChangePassword
                    ? MyProgressIndicator()
                    : MyGradientButton(
                        onPressed: () async {
                          await controller.changePasswordWithTemp();
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
