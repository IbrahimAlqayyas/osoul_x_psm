import 'package:flutter/services.dart';

class TextFormatters {
  /// Allows only Arabic and English letters with spaces.
  TextInputFormatter characterOnly = FilteringTextInputFormatter.allow(
    RegExp(r'[أإآا-يءؤئءa-zA-Z\s]'),
  );

  /// Denies Arabic numbers (٠-٩).
  TextInputFormatter denyArabicNumbers = FilteringTextInputFormatter.deny(RegExp(r'[٠-٩]'));

  /// Removes spaces, useful for email formatting.
  TextInputFormatter noSpaces = FilteringTextInputFormatter.deny(RegExp(r'\s'));

  /// Allows only English numbers (0-9), useful for phone numbers.
  TextInputFormatter englishNumbersOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  /// Denies leading spaces, but allows spaces elsewhere in the string.
  TextInputFormatter noLeadingSpacesOrZeros = _NoLeadingSpacesTextInputFormatter();
}

class _NoLeadingSpacesTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && newValue.text[0] == ' ') {
      // If the first character is a space, return the old value to prevent leading space.
      return oldValue;
    } else if (newValue.text.isNotEmpty && newValue.text[0] == '0') {
      // If the first character is a 0, return the old value to prevent leading space.
      return oldValue;
    }
    return newValue;
  }
}
