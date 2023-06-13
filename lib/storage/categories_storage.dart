import 'dart:convert';
import 'package:languages/json/json_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesStorage {
  static const String CATEGORIES = 'categories';

  static Future<bool> isEmpty() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return !preferences.containsKey(CATEGORIES);
  }

  static Future<List<JsonCategory>> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String data = preferences.getString(CATEGORIES) ?? '[]';
    final dynamic json = jsonDecode(data);

    return JsonCategory.fromJsonList(json);
  }

  static Future save(List<JsonCategory> categories) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(CATEGORIES, jsonEncode(categories));
  }
}
