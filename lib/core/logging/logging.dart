import 'dart:developer';
import 'package:osoul_x_psm/core/helpers/string_helpers.dart';

/// Universal Logging Function with Colors
void kLog(
  dynamic value, {
  bool separate = false,
  String emoji = '🍉🍉',
  bool colored = false,
  String? color, // optional custom color
}) {
  String line = separate ? '\n' : '';

  String text = '$line$emoji ${value.toString()}$line';

  // Apply color if enabled
  if (colored) {
    final chosenColor = color ?? LogColor.magenta; // default: yellow
    text = '$chosenColor$text${LogColor.reset}';
  }

  log(text);
}

/// ANSI Color Codes
class LogColor {
  static const reset = '\x1B[0m';

  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';
}

class Logging {
  /// Local, Print Service Headers
  void printHeaders(String serviceName, headers) {
    kLog("<${serviceName.toUpperCase()}> HEADERS: $headers", emoji: '🟦');
  }

  /// Local, Print Service Status Code
  void printStatusCode(String serviceName, statusCode) {
    String s;
    if (statusCode.toString() == '200' || statusCode.toString() == '201') {
      s = '✅✅';
    } else {
      s = '❌❌';
    }
    log('$s <${serviceName.toUpperCase()}> CODE: $statusCode $s');
  }

  /// Local, Print Service Response Body
  void printResponseBody(String serviceName, String responseBody) {
    kLog(
      "<${serviceName.toUpperCase()}> RESPONSE BODY: ${responseBody.inPrettyJson()}",
      emoji: '🤖',
    );
  }

  /// Local
  void printException(String serviceName, String e, {StackTrace? stackTrace}) {
    log('');
    log('❌❌❌❌❌❌❌❌❌❌❌❌❌');
    log('❌❌❌❌ EXCEPTION ❌❌❌❌');
    log('❌❌❌❌❌❌❌❌❌❌❌❌❌');
    log('');
    log(e);
    log(
      '<${serviceName.toUpperCase()}> SERVICE EXCEPTION STACKTRACE =============',
      stackTrace: stackTrace,
    );
  }
}

enum LoggingCategory { test, report, exception, serverIssue, connectivityIssue, unknown }
