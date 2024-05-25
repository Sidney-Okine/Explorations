import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/UserModel.dart';

class Manager {
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<void> saveUserModel(String key, UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(userModel.toJson());
    prefs.setString(key, jsonString);
  }

  static Future<UserModel?> getUserModel(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> userMap = jsonDecode(jsonString);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  static Future<void> saveUserLoggedInStatus(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
  }

  static Future<bool?> isUserLoggedIn(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
  }

}
