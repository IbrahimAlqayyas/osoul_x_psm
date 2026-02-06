import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/app/environment.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';

import 'package:osoul_x_psm/core/shared_widgets/snackbar.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:osoul_x_psm/features/home/views/home_view.dart';
// import 'package:osoul_x_psm/features/home/views/home_view.dart';
import 'package:osoul_x_psm/features/profile/views/change_password_view.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoadingLogin = false;
  bool isObscure = true;

  @override
  void onInit() {
    super.onInit();
    // Show environment selection dialog when entering login page
    // _showEnvironmentDialog();
  }

  // void _showEnvironmentDialog() {
  //   // Import the dialog function
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     showEnvironmentSelectionDialog(
  //       isDismissible: false,
  //       onEnvironmentChanged: (environment) {
  //         // Environment has been selected and saved
  //         update();
  //       },
  //     );
  //   });
  // }

  obscureControl() {
    isObscure = !isObscure;
    update();
  }

  login() async {
    isLoadingLogin = true;
    update();

    UserModel? user = await Services().login(emailController.text, passwordController.text);

    kLog('user');
    kLog(user);
    if (user != null) {
      if (user.changePassRequired == true) {
        Get.to(
          () => ChangePasswordView(
            email: user.email,
            onPasswordReset: () async {
              await Preferences().saveUser(user);
              await saveEnvironment(kAppEnvironment!);
              Get.offAll(() => HomeViewWorkOrders());
            },
          ),
        );
        showSnackBar(haveToChangePassword.tr, type: SnackBarType.warning);
      } else {
        await Preferences().saveUser(user);
        await saveEnvironment(kAppEnvironment!);
        Get.offAll(() => HomeViewWorkOrders());
      }
    } else {
      showSnackBar(loginError.tr, type: SnackBarType.failure);
    }

    isLoadingLogin = false;
    update();
  }
}
