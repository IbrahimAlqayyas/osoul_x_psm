import 'package:osoul_x_psm/core/app/environment.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static final AppVersion _instance = AppVersion._internal();

  factory AppVersion() => _instance;

  AppVersion._internal();

  String? _version;
  String? _buildNumber;

  /// Must be called once at app startup (e.g. in main)
  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _instance._version = packageInfo.version;
    _instance._buildNumber = packageInfo.buildNumber;
  }

  static String getVersion() {
    final version = _instance._version ?? '1.0.0';
    final build = _instance._buildNumber ?? '0';

    final envSuffix = kAppEnvironment?.getEnvironment() ?? '';

    if (kAppEnvironment is Production) {
      return 'v$version';
    } else {
      return 'v$version+$build $envSuffix';
    }
  }
}
