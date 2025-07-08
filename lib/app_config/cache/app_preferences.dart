import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences (call in main before runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Example keys
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUsername = 'username';

  // Getter and setter for isLoggedIn
  static bool get isLoggedIn => _prefs?.getBool(_keyIsLoggedIn) ?? false;

  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(_keyIsLoggedIn, value);
  }

  // Getter and setter for username
  static String? get username => _prefs?.getString(_keyUsername);

  static Future<void> setUsername(String value) async {
    await _prefs?.setString(_keyUsername, value);
  }

  /// General getters and setters for reuse
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
