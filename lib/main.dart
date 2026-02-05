import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osoul_x_psm/core/app/environment.dart';
import 'package:osoul_x_psm/core/app/version.dart';
import 'package:osoul_x_psm/core/localization/02_app_translations.dart';
import 'package:osoul_x_psm/core/localization/03_supported_locales.dart';
import 'package:osoul_x_psm/core/localization/04_localization_service.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/splash/presentation/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Locale? activeLocale;
const String kRoboto = 'Roboto Condensed';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Preferences().clear();
  await initializeEnvironment(); // Initialize environment before anything else
  await LocalizationService().initialize();
  await AppVersion.init();
  disableLandscapeOrientation();
  removeStatusBarColor();
  // Preferences().clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'X-PSM',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      locale: activeLocale ?? SupportedLocales().arabic,
      fallbackLocale: SupportedLocales().arabic,
      supportedLocales: SupportedLocales().all,
      translations: AppTranslations(),
      translationsKeys: AppTranslations().keys,
      // defaultTransition: Transition.fade,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        cardColor: kWhiteColor,
        useMaterial3: true,
        fontFamily: 'Tajawal',
        fontFamilyFallback: const ['Roboto Condensed'],
        dialogTheme: DialogThemeData(backgroundColor: kWhiteColor),
      ),
      builder: (context, child) {
        // Ensure status bar settings persist across navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          removeStatusBarColor();
        });

        final mediaQuery = MediaQuery.of(context);
        final hasBottomNotch = mediaQuery.viewPadding.bottom > 0;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
          child: Padding(
            padding: EdgeInsets.only(bottom: hasBottomNotch ? 9 : 0),
            child: child!,
          ),
        );
      },
      home: const SplashView(),
    );
  }
}

void disableLandscapeOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void removeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.light, // White icons (Android)
      statusBarBrightness: Brightness.light, // White icons (iOS)
      systemStatusBarContrastEnforced: false,
      // Additional settings to ensure proper behavior
      // systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // Also set the preferred orientations to ensure consistent behavior
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
