import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/logging/logging.dart';
import '../../main.dart';
import '../preferences/preferences.dart';
import '03_supported_locales.dart';
import 'package:intl/date_symbol_data_local.dart';

class LocalizationService {
  Future<void> initialize() async {
    await getSavedLocale();
    await initializeDateFormatting('en');
    await initializeDateFormatting('ar');
  }

  /// get the locale from the storage
  Future<void> getSavedLocale() async {
    String? loc = await Preferences().getString(PrefsKeys().localeString);

    if (loc == null) {
      kLog('loc=null');
      await setLocale(SupportedLocales().arabic);
    } else {
      kLog('loc=$loc');
      await setLocale(Locale(loc));
    }
  }

  /// updates the locale in the main.dart & the locale string in the storage
  Future<void> setLocale(Locale locale) async {
    activeLocale = locale;

    /// force update the layout
    await Get.updateLocale(locale);
    await Preferences().setString(PrefsKeys().localeString, locale.toString());
  }
}
