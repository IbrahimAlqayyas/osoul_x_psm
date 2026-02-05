import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';

class Validators {
  String? isValidName(String? name, {int maxLength = 15, int minLength = 2}) {
    {
      if (name == null || name.isEmpty) {
        return 'cannotBeEmpty'.tr;
      } else if (name.length > maxLength) {
        return 'max15Chars'.tr;
      } else if (name.length < minLength) {
        return 'min2Chars'.tr;
      } else if (RegExp(r'\d+').hasMatch(name)) {
        return 'cannotContainNumbers'.tr;
      }
      return null;
    }
  }

  String? isValidEmailAddress(String? email) {
    final validEmailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty) {
      return 'cannotBeEmpty'.tr;
    } else if (!validEmailRegExp.hasMatch(email)) {
      return 'enterValidEmail'.tr;
    }
    return null;
  }

  String? isValidCellphone(String cellphone, String countryKey) {
    if (cellphone.isEmpty) {
      return 'cannotBeEmpty'.tr;
    } else if (countryKey == 'sa' && !cellphone.startsWith('5')) {
      return 'startWith5'.tr;
    } else if (countryKey == 'eg' && !cellphone.startsWith('1')) {
      return 'startWith1'.tr;
    } else if (countryKey == 'sa' && cellphone.length != 9) {
      return 'mustBe9DigitsForThisCountry'.tr;
    } else if (countryKey == 'eg' && cellphone.length != 10) {
      return 'mustBe10DigitsForThisCountry'.tr;
    }
    return null;
  }

  bool isValidCellphoneBool(String cellphone, String countryKey) {
    if (cellphone.isEmpty) {
      return false;
    } else if (countryKey == 'sa' && !cellphone.startsWith('5')) {
      return false;
    } else if (countryKey == 'eg' && !cellphone.startsWith('1')) {
      return false;
    } else if (countryKey == 'sa' && cellphone.length != 9) {
      return false;
    } else if (countryKey == 'eg' && cellphone.length != 10) {
      return false;
    }
    return true;
  }

  String? maxTo(String? value, int max) {
    if (value == null) return null;
    if (value.length > max) {
      return maxCharactersAllowed.trParams({'max': '$max'});
    }
    return null;
  }

  // static isValidCellphoneOptional(
  //   String cellphone,
  //   String countryKey, {
  //   bool compare = false,
  //   String comparedWith = '',
  // }) {
  //   if (cellphone.isNotEmpty &&
  //       countryKey == 'sa' &&
  //       !cellphone.startsWith('5')) {
  //     return 'startWith5'.tr;
  //   } else if (cellphone.isNotEmpty &&
  //       countryKey == 'eg' &&
  //       !cellphone.startsWith('1')) {
  //     return 'startWith1'.tr;
  //   } else if (cellphone.isNotEmpty && cellphone.length < 9 ||
  //       cellphone.isNotEmpty && cellphone.length > 11) {
  //     return 'mustBe9To11Digits'.tr;
  //   } else if (cellphone.isNotEmpty &&
  //       countryKey == 'sa' &&
  //       cellphone.length != 9) {
  //     return 'mustBe9DigitsForThisCountry'.tr;
  //   } else if (cellphone.isNotEmpty &&
  //       countryKey == 'eg' &&
  //       cellphone.length != 10) {
  //     return 'mustBe10DigitsForThisCountry'.tr;
  //   } else if (compare) {
  //     String? currentCellphone = Get.find<UserController>().user?.phoneNumber;
  //     if (currentCellphone?.contains(cellphone) == true &&
  //         cellphone.isNotEmpty) {
  //       return 'takenCellphone'.tr;
  //     }
  //   }
  //   return null;
  // }

  String? isValidPassword(String password, {bool isConfirm = false, String passwordRef = ''}) {
    // final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');
    final regex = RegExp(r'^(?=.*[a-zA-Zا-ي])(?=.*\d).{8,}$');

    if (password.isEmpty) {
      return cannotBeEmpty.tr;
    } else if (isConfirm && password != passwordRef) {
      return passwordMustMatch.tr;
    } else if (password.length < 8) {
      return cannotLess8.tr;
    } else if (!regex.hasMatch(password)) {
      return passwordMustContain.tr;
    }
    return null;

    //   final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$');
    //
    //   if (password.isEmpty) {
    //     return 'Please enter a password';
    //   } else if (password.length < 8) {
    //     return 'Cannot be less than 8 characters';
    //   } else if (!regex.hasMatch(password)) {
    //     return 'Must have Upper/lower case letters, numbers and special characters';
    //   }
    //   return null;
    // }
  }

  String? isNotNull(String? str) {
    if (str == null || str.isEmpty) {
      return cannotBeEmpty.tr;
    }
    return null;
  }

  String? cannotStartWithZero(String? value) {
    if (value == null || value.isEmpty) {
      return cannotBeEmpty.tr;
    } else if (value.startsWith('0')) {
      return cannotStartWithZeroStr.tr;
    }
    return null;
  }
}
