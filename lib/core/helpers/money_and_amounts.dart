import 'package:tuple/tuple.dart';

/// ///////////////////////////////////////////////////////////////////////////////////////////
/// HELPERS
/// ///////////////////////////////////////////////////////////////////////////////////////////

Tuple2<String, String> splitNumberToIntAndFraction(num number) {
  int integerPart = number.toInt();
  int fractionPart = ((number - integerPart) * 100).round();
  String fractionString = '00';

  if (fractionPart.toString().length == 1) {
    if (fractionPart == 0) {
      fractionString = '00';
    } else {
      fractionPart = fractionPart * 10;
      fractionString = fractionPart.toString();
    }
  } else if (fractionPart.toString().length == 2) {
    fractionString = fractionPart.toString();
  } else {
    //length > 2
    fractionString = (fractionPart / (10 ^ fractionPart.toString().length)).toStringAsFixed(2);
  }

  return Tuple2(integerPart.toString()._commaSeparated(), fractionString);
}

extension NumberFormatting on dynamic {
  String toMoney() {
    return num.parse(toString())._padLeftFraction()._commaSeparated();
  }

  String _padLeftFraction() {
    return num.parse(toString()).toStringAsFixed(2);
  }
}

extension NumberFormattingS on String {
  String _commaSeparated() {
    return replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
