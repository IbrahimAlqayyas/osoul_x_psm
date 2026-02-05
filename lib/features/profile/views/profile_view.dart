import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/features/profile/controllers/profile_controller.dart';
import 'package:osoul_x_psm/features/profile/views/change_password_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: profileTitle.tr,
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Column(children: [_buildPasswordItem(controller)]);
        },
      ),
    );
  }
}

Widget _buildPasswordItem(ProfileController controller) {
  final TextEditingController passwordController = TextEditingController(text: '••••••••');

  return Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1), width: 1)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Leading Icon
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E9EC),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.lock_outline, size: 24, color: Color(0xFF002544)),
        ),
        const SizedBox(width: 12),

        // Password Field
        Expanded(
          child: CustomTextFieldWidget(
            title: password.tr,
            hint: '••••••••',
            controller: passwordController,
            isEditable: false,
            showObscureToggle: false,
            isObscure: true,
          ),
        ),
        const SizedBox(width: 12),

        // Reset Button
        controller.isLoadingChangePassword
            ? MyProgressIndicator()
            : MyGradientButton(
                width: 90,
                height: 50,
                label: resetPassword.tr,
                onPressed: () {
                  Get.to(() => const ChangePasswordView());
                },
              ),
      ],
    ),
  );
}
