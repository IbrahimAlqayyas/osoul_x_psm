import 'package:flutter/material.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/features/auth/controllers/login_controller.dart';
import 'package:osoul_x_psm/features/auth/views/forgot_password_view.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: loginTitle.tr,
      showBackButton: false,
      body: GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VPadding(25),
              CustomTextFieldWidget(
                title: emailLabel.tr,
                hint: 'name@example.com',
                controller: controller.emailController,
              ),

              const VPadding(16),
              CustomTextFieldWidget(
                title: passwordLabel.tr,
                hint: '********',
                controller: controller.passwordController,
                isObscure: controller.isObscure,
                showObscureToggle: true,
              ),

              const VPadding(8),

              // Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordView());
                  },
                  child: Text(
                    forgotPassword.tr,
                    style: const TextStyle(
                      color: Color(0xFF68408C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const VPadding(24),

              Center(
                child: controller.isLoadingLogin
                    ? MyProgressIndicator()
                    : MyGradientButton(
                        onPressed: () {
                          controller.login();
                        },
                        label: loginTitle.tr,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
