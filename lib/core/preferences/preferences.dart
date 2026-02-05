import 'dart:convert';
// import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsKeys {
  String savedUser = 'savedUser';
  String localeString = 'localeString';
  String savedEnvironment = 'savedEnvironment';
}

class Preferences {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// implement get string
  getString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  /// implement set string
  setString(String key, String value) async {
    SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await _prefs;
    // prefs.remove(PreferencesKeys.token);
    return prefs.clear();
  }

  /// Get list of SavedUserModel from preferences (empty if none)
  Future<UserModel?> getSavedUser() async {
    SharedPreferences prefs = await _prefs;
    final jsonString = prefs.getString(PrefsKeys().savedUser);
    if (jsonString == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUser(UserModel user) async {
    SharedPreferences prefs = await _prefs;
    final String encoded = jsonEncode(user.toJson());
    return await prefs.setString(PrefsKeys().savedUser, encoded);
  }
}
