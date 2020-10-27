import 'dart:convert';
import 'package:Languages/json/json_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage {
  static const String PROFILE = 'profile';

  static Future<bool> isEmpty() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return !prefs.containsKey(PROFILE);
  }

  static Future<JsonProfile> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String data = prefs.getString(PROFILE);
    final dynamic json = jsonDecode(data);

    return JsonProfile.fromJson(json);
  }

  static Future save(JsonProfile profile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PROFILE, jsonEncode(profile));
  }

  static Future clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(PROFILE);
  }
}
