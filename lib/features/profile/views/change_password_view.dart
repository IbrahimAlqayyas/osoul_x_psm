import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/features/profile/controllers/profile_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key, this.onPasswordReset, this.email});
  final Function? onPasswordReset;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: passwordChangeTitle.tr,
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VPadding(25),

              // Current Password Field
              CustomTextFieldWidget(
                title: currentPassword.tr,
                hint: '********',
                controller: controller.currentPasswordController,
                isObscure: controller.isCurrentPasswordObscure,
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

              // Change Password Button
              Center(
                child: controller.isLoadingChangePassword
                    ? MyProgressIndicator()
                    : MyGradientButton(
                        onPressed: () async {
                          await controller.changePassword(
                            email: email,
                            currentPassword: controller.currentPasswordController.text,
                            newPassword: controller.newPasswordController.text,
                            onPasswordReset: onPasswordReset,
                          );
                        },
                        label: changePassword.tr,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
