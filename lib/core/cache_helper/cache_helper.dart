import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_values.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static bool isEnglish() => getCurrentLanguage() == "en";

  static void changeLanguageToEn() async {
    await CacheHelper.saveData(key: CacheKeys.currentLanguage, value: "en");
  }

  static bool isLoggedIn() {
    return CacheHelper.getData(key: CacheKeys.uId) != null;
  }
  static bool isOffline = false;
  static Future<String> initializeConnction() async {
    final InternetConnectionChecker connectionChecker = InternetConnectionChecker.createInstance();
    final connected = await connectionChecker.hasConnection;
    isOffline = !connected;
    return connected ? Routes.homeScreen : Routes.loginScreen;
  }

  static String getCurrentLanguage() {
    // print(CacheHelper.getData( key: CacheKeys.currentLanguage,));
    return CacheHelper.getData(
          key: CacheKeys.currentLanguage,
        ) ??
        "en";
  }
  static bool isDesktop(BuildContext context) {
    var isDesktop = MediaQuery.sizeOf(context).width >= 600;
    return isDesktop;
  }
  static void changeLanguageToAr() async {
    await CacheHelper.saveData(key: CacheKeys.currentLanguage, value: "ar");
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await sharedPreferences.clear();
  }
}
