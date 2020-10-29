import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class KnownWordsStorage {
  static const String KNOWN_WORDS = 'known.words';
  static final List<String> knownWords = [];

  static Future init() async {
    knownWords.clear();
    knownWords.addAll(await load());
  }

  static bool contains(String word) => knownWords.contains(word);

  static Future add(String word) async {
    final List<String> result = await load();
    result.add(word);
    knownWords.add(word);
    _save(result);
  }

  static Future remove(String word) async {
    final List<String> result = await load();
    result.remove(word);
    knownWords.remove(word);
    _save(result);
  }

  static Future<List<String>> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(KNOWN_WORDS)) {
      final String data = prefs.getString(KNOWN_WORDS);
      final List<dynamic> json = jsonDecode(data) as List<dynamic>;
      final List<String> list = json.map((w) => w.toString()).toList();
      list.sort((w1, w2) => w1.compareTo(w2));

      return list;
    } else {
      return [];
    }
  }

  static Future _save(List<String> words) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KNOWN_WORDS, jsonEncode(words));
  }
}
