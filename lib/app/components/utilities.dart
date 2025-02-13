import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static Map<String, String> getHeadersWithToken(String? accessToken) {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
  }

  static Map<String, String> getHeadersWithoutToken() {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  static void setStringPreference(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value ?? "");
  }

  static Future<String> getStringPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static void setBoolPreference(String key, bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value ?? false);
  }

  static Future<bool> getBoolPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

}