import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';

// Global variable to hold the current environment
AppEnvironment? kAppEnvironment;

// Initialize environment from saved preferences or default to staging
Future<void> initializeEnvironment() async {
  /// manual set of environment
  kAppEnvironment = Staging();
  // kAppEnvironment = Production();
  final String? savedEnv = await Preferences().getString(PrefsKeys().savedEnvironment);
  kLog('kAppEnvironment?.environment != savedEnv => ${kAppEnvironment?.environment != savedEnv}');
  if (kAppEnvironment?.environment != savedEnv) {
    await Preferences().clear();
    return;
  }
  if (savedEnv == 'production') {
    kAppEnvironment = Production();
  } else {
    // Default to staging
    kAppEnvironment = Staging();
  }
}

// Save selected environment to preferences
Future<void> saveEnvironment(AppEnvironment environment) async {
  await Preferences().setString(PrefsKeys().savedEnvironment, environment.environment);
  kAppEnvironment = environment;
}

abstract class AppEnvironment {
  late String environment;

  String getEnvironment();
}

class Staging implements AppEnvironment {
  @override
  String environment = 'staging';

  @override
  String getEnvironment() {
    return '(staging)';
  }
}

class Production implements AppEnvironment {
  @override
  String environment = 'production';

  @override
  String getEnvironment() {
    return '';
  }
}
