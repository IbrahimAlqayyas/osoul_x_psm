import 'dart:convert';
import 'dart:ui';

import 'package:osoul_x_psm/core/localization/03_supported_locales.dart';

class StringHelpers {
  String? replace({String? str, String from = '\n', String to = '\\\n'}) {
    if (str == null || !str.contains(from)) {
      return str;
    }
    return str.replaceAll(from, to);
  }

  String maskCardNumber(String cardNumber) {
    if (cardNumber.length < 14) {
      return cardNumber;
    }

    String maskedNumber = cardNumber.substring(0, 12).replaceAll(RegExp(r'\d'), '*');
    maskedNumber += cardNumber.substring(12);
    return maskedNumber;
  }

  num getNumFromString(String str, String stringToRemove) {
    try {
      num returnValue = num.parse(
        str.toLowerCase().replaceAll(' ', '').replaceAll(stringToRemove.toLowerCase(), ''),
      );
      return returnValue;
    } catch (e) {
      // In case parsing fails, return 0 as default
      return 0;
    }
  }
}

extension StringExtensions on String {
  String inPrettyJson() {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonDecode(this));
  }
}

extension StringZeroingExtensions on String {
  String zeroIfEmpty() {
    if (isEmpty) return '0';
    return this;
  }
}

extension StringCasingExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

String getStNdTh(int number, Locale activeLocale) {
  if (activeLocale == SupportedLocales().english) {
    if (number.toString().endsWith('1')) {
      return 'st';
    } else if (number.toString().endsWith('2')) {
      return 'nd';
    } else if (number.toString().endsWith('3')) {
      return 'rd';
    } else {
      return 'th';
    }
  } else {
    return '';
  }
}
