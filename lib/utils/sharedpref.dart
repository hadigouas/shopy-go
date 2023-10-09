import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static SharedPreferences? sharedPreferences;

  static Future<void> initializeShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print('done');
  }

  // Set the variable in the cache
  static Future<bool> setData(String key, dynamic value) async {
    if (sharedPreferences != null) {
      if (value is bool) {
        await sharedPreferences!.setBool(key, value);
        return true;
      }
    }
    return false;
  }

  static bool? getData(String key) {
    return sharedPreferences?.getBool(key);
  }
}
