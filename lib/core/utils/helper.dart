import 'package:shared_preferences/shared_preferences.dart';

class HelperFunc {
  static setSms(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sms', value);
  }

  static Future<bool> getSms() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('sms') ?? false;
  }

  static setNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification', value);
  }

  static Future<bool> getNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification') ?? false;
  }
}
