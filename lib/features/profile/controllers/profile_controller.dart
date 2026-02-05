import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';

class ProfileController extends GetxController {
  // Text controllers
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // Obscure state
  bool isCurrentPasswordObscure = true;
  bool isNewPasswordObscure = true;

  bool isLoadingChangePassword = false;

  UserModel? user;

  /// Change password method
  /// Returns true if password change is successful, false otherwise
  Future<void> changePassword({
    String? email,
    required String currentPassword,
    required String newPassword,
    Function? onPasswordReset,
  }) async {
    kLog('Changing Password .....');
    isLoadingChangePassword = true;
    update();

    try {
      Map<String, dynamic> body = {
        'email': email ?? user!.email,
        'oldpassword': currentPassword,
        'newpassword': newPassword,
      };
      kLog(body);
      bool isReset = await Services().changePassword(body);

      if (isReset) {
        showSuccessDialog();
        onPasswordReset?.call();
      } else {
        showFailureDialog();
      }
      isLoadingChangePassword = false;
      update();
    } catch (e, s) {
      kLog(e);
      kLog(s);
      isLoadingChangePassword = false;
      update();
    }
  }

  getUser() async {
    // user = await Preferences().getSavedUser();
    kLog(user?.toJson());
    update();
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
