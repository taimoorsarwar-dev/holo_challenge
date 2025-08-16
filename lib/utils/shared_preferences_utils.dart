import 'dart:convert';

import 'package:holo_challenge/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A helper class for interacting with SharedPreferences.
class SharedPreferencesUtils {
  // Singleton instance of SharedPreferences
  static SharedPreferences? _prefs;

  /// Returns the SharedPreferences instance (caches it after first use)
  static Future<SharedPreferences> _getInstance() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save an integer value
  static Future<bool?> saveInt({required String key, int? value}) async {
    try {
      if (value != null) {
        final prefs = await _getInstance();
        return await prefs.setInt(key, value);
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Save a double value
  static Future<bool?> saveDouble({required String key, double? value}) async {
    try {
      if (value != null) {
        final prefs = await _getInstance();
        return await prefs.setDouble(key, value);
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Save a boolean value
  static Future<bool?> saveBool({required String key, bool? value}) async {
    if (value != null) {
      final prefs = await _getInstance();
      return await prefs.setBool(key, value);
    }
    return null;
  }

  /// Save a string value
  static Future<bool?> saveString({required String key, String? value}) async {
    try {
      if (value != null && value.isNotEmpty) {
        final prefs = await _getInstance();
        return await prefs.setString(key, value);
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Save String List
  static Future<bool?> saveStringList({
    required String key,
    List<String>? value,
  }) async {
    try {
      if (value != null && value.isNotEmpty) {
        final prefs = await _getInstance();
        return await prefs.setStringList(key, value);
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Save Map object
  static Future<bool?> saveObject({required String key, var value}) async {
    try {
      if (value != null) {
        final prefs = await _getInstance();
        String? encoded;

        encoded = jsonEncode(value);

        return await prefs.setString(key, encoded);
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an integer value
  static Future<int?> getInt({required String key}) async {
    try {
      final prefs = await _getInstance();
      return prefs.getInt(key);
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an double value
  static Future<double?> getDouble({required String key}) async {
    try {
      final prefs = await _getInstance();
      return prefs.getDouble(key);
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an boolean value
  static Future<bool?> getBool({required String key}) async {
    try {
      final prefs = await _getInstance();
      return prefs.getBool(key);
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an String value
  static Future<String?> getString({required String key}) async {
    try {
      final prefs = await _getInstance();
      return prefs.getString(key);
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an List<String> value
  static Future<List<String>?> getStringList({required String key}) async {
    try {
      final prefs = await _getInstance();
      return prefs.getStringList(key);
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  /// Get an Map Object value
  static Future<dynamic> getObject({required String key}) async {
    try {
      final prefs = await _getInstance();
      String? value = prefs.getString(key);
      if (value != null) {
        var decoded = jsonDecode(value);
        return decoded;
      }
    } catch (e, stack) {
      _printError(error: e, stackTrace: stack);
    }
    return null;
  }

  static void _printError({Object? error, StackTrace? stackTrace}) {
    AppLogger.log('SharedPrefUtils error: $error', LoggingType.error);
  }
}
