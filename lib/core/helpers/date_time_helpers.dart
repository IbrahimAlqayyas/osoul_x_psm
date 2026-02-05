import 'dart:ui';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:osoul_x_psm/main.dart';
import '../localization/01_translation_keys.dart';
import '../localization/03_supported_locales.dart';

class DateTimeHelpers {
  /// Parse Date/Time String - Return Date/Time
  String getLocalDateTime(String dateTimeString) {
    var dateTime = DateTime.parse(dateTimeString).toLocal();
    return '$dateTime';
  }

  /// Parse Date/Time String - Return Date/Time
  DateTime returnDateTime(String dateTimeString) {
    var dateTime = DateTime.parse(dateTimeString).toLocal();
    return dateTime;
  }

  /// Parse Date/Time String - Return Custom Date/Time String
  String returnDateTimeString(String? dateTimeString) {
    if (dateTimeString == null) return '';
    var dateTime = DateTime.parse(dateTimeString).toLocal();
    String dateString = DateFormat('d/M/y').format(dateTime);
    String timeString = DateFormat('hh:mm a', activeLocale.toString()).format(dateTime);
    return replaceArabicHindiNumbers('$dateString  $timeString');
  }

  String returnDateString(String? dateTimeString) {
    try {
      if (dateTimeString == null) {
        return '';
      }
      var dateTime = DateTime.parse(dateTimeString).toLocal();
      String dateString = DateFormat('d/M/y').format(dateTime);
      // String timeString = DateFormat('hh:mm a').format(dateTime);
      return dateString;
    } catch (_) {
      return noDateException.tr;
    }
  }

  /// Parse Date/Time String - Return Custom Date/Time String
  String returnTimeString(String dateTimeString) {
    var dateTime = DateTime.parse(dateTimeString).toLocal();
    String timeString = DateFormat('hh:mm a').format(dateTime);
    return timeString;
  }

  /// Parse Date/Time - Return Description (today, yesterday .. etc)
  String returnDescriptionStringDateAndTime(String? dateTimeString, Locale activeLocale) {
    if (dateTimeString == null) return '';
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();

    // Helper to compare dates only (ignoring time)
    bool isSameDate(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    // Calculate day difference using only dates (midnight baseline)
    int diff = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(dateTime.year, dateTime.month, dateTime.day)).inDays;

    String timeString = DateFormat(
      'hh:mm a',
      activeLocale == SupportedLocales().arabic ? 'ar' : 'en',
    ).format(dateTime);

    if (activeLocale == SupportedLocales().arabic) {
      timeString = replaceArabicHindiNumbers(timeString);
    }
    if (isSameDate(dateTime, now)) {
      return todayWithTime.trParams({'time': timeString});
    } else if (diff == 1) {
      return yesterdayWithTime.trParams({'time': timeString});
    }
    // else if (diff == 2) {
    //   return activeLocale == SupportedLocales().arabic
    //       ? 'منذ يومين $timeString'
    //       : '2 days ago $timeString';
    // }
    // else if (diff <= 5 && diff > 0) {
    //   return activeLocale == SupportedLocales().arabic
    //       ? 'منذ $diff أيام $timeString'
    //       : '$diff days ago $timeString';
    // }
    else {
      String dateString = DateFormat('d/M/y').format(dateTime);
      return '$dateString $timeString';
    }
  }

  /// Parse Date/Time - Return Description (today, yesterday .. etc)
  String returnDescriptionStringDate(String dateTimeString, Locale activeLocale) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();

    bool isSameDate(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    if (isSameDate(dateTime, now)) {
      return todayLabel.tr;
    }

    int diff = now.difference(DateTime(dateTime.year, dateTime.month, dateTime.day)).inDays;

    if (diff == 1) {
      return yesterdayLabel.tr;
    } else if (diff == 2) {
      return twoDaysAgoLabel.tr;
    }
    // else if (diff <= 5) {
    //   return activeLocale == SupportedLocales().arabic ? 'منذ $diff أيام' : '$diff days ago';
    // }
    else {
      return DateFormat('d/M/y').format(dateTime);
    }
  }

  int returnTimeHour(String dateTimeString) {
    var dateTime = DateTime.parse(dateTimeString).toLocal();
    int time = int.parse(DateFormat('H').format(dateTime));
    return time;
  }

  Duration returnDuration({required String from, required String to}) {
    DateTime dateFrom = DateTime.parse(from).toLocal();
    DateTime dateTo = DateTime.parse(to).toLocal();
    Duration duration = dateTo.difference(dateFrom);
    return duration;
  }

  String getDayName(DateTime date, Locale activeLocale) {
    final formatter = DateFormat('EEEE', activeLocale == SupportedLocales().arabic ? 'ar' : 'en');
    return formatter.format(date);
  }

  String getMonthName(DateTime date, Locale activeLocale) {
    final formatter = DateFormat('MMMM', activeLocale == SupportedLocales().arabic ? 'ar' : 'en');
    return formatter.format(date);
  }

  String getDateWithoutTime(String dateTimeString, Locale activeLocale) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  // Tue, Nov 5
  String formatDateString(String inputDate, Locale activeLocale) {
    DateTime date = DateTime.parse(inputDate).toLocal();
    DateFormat formatter = DateFormat(
      'EEE, d MMM',
      activeLocale == SupportedLocales().arabic ? 'ar' : 'en',
    );
    String formattedDate = formatter.format(date);
    return replaceArabicHindiNumbers(formattedDate);
  }

  // Tue, Nov 5
  String formatDateStringWithTime(String inputDate, Locale activeLocale) {
    DateTime date = DateTime.parse(inputDate).toLocal();
    DateFormat formatter = DateFormat(
      'EEE, d MMM yyyy - hh:mm a',
      activeLocale == SupportedLocales().arabic ? 'ar' : 'en',
    );
    String formattedDate = formatter.format(date);
    return replaceArabicHindiNumbers(formattedDate);
  }

  String replaceArabicHindiNumbers(String text) {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩'; // Arabic numbers
    const hindiNumbers = '०१२३४५६७८९'; // Hindi numbers
    const englishNumbers = '0123456789';

    for (int i = 0; i < arabicNumbers.length; i++) {
      text = text.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }

    for (int i = 0; i < hindiNumbers.length; i++) {
      text = text.replaceAll(hindiNumbers[i], englishNumbers[i]);
    }

    return text;
  }
}
