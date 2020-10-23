import 'dart:convert';
import 'package:Languages/json/json_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesStorage {
  static const String CATEGORIES = 'categories';

  static Future<bool> isEmpty() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return !prefs.containsKey(CATEGORIES);
  }

  static Future<List<JsonCategory>> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String data = prefs.getString(CATEGORIES);
    final dynamic json = jsonDecode(data);

    return JsonCategory.fromJsonList(json);
  }

  static Future save(List<JsonCategory> categories) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CATEGORIES, jsonEncode(categories));
  }
}
