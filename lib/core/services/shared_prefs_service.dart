import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /*-------------- Save data ---------------*/
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await _sharedPreferences.setInt(key, value);
    }
    print('String data: $value -> saved successfully');
    return true;
  }

  /*------------ Get data from shared prefs --------------*/
  static Object? getData({required String key}) {
    Object? value = _sharedPreferences.get(key);
    return value;
  }

  static Future<bool> clearStringData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  static Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    print('All data cleared successfully');
    return true;
  }
}
