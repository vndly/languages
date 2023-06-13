import 'dart:convert';
import 'package:languages/json/json_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage {
  static const String PROFILE = 'profile';

  static Future<bool> isEmpty() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return !preferences.containsKey(PROFILE);
  }

  static Future<JsonProfile> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String data = preferences.getString(PROFILE) ?? '{}';
    final dynamic json = jsonDecode(data);

    return JsonProfile.fromJson(json);
  }

  static Future save(JsonProfile profile) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PROFILE, jsonEncode(profile));
  }

  static Future clear() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(PROFILE);
  }
}
