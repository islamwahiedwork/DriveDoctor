
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences  ;

  static const language = "Language";


  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  static Future<bool?> setData({
     required String key,
     required dynamic value,
  }) async {
    if (value is double) {
      return await sharedPreferences?.setDouble(key, value);
    } else if (value is String) {
      return await sharedPreferences?.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences?.setInt(key, value);
    }
    return await sharedPreferences?.setBool(key, value);
  }

  static Future<bool?> remove({
    required String key,
  }) async {
   return sharedPreferences?.remove(key);

  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }
}
