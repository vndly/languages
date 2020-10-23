import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class KnownWordsStorage {
  static const String KNOWN_WORDS = 'known.words';
  static final List<String> knownWords = [];

  static Future init() async {
    knownWords.clear();
    knownWords.addAll(await _loadKnownWords());
  }

  static bool contains(String word) => knownWords.contains(word);

  static Future add(String word) async {
    final List<String> result = await _loadKnownWords();
    result.add(word);
    knownWords.add(word);
    _saveKnownWords(result);
  }

  static Future<List<String>> _loadKnownWords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(KNOWN_WORDS)) {
      final String data = prefs.getString(KNOWN_WORDS);
      final List<dynamic> json = jsonDecode(data) as List<dynamic>;

      return json.map((w) => w.toString()).toList();
    } else {
      return [];
    }
  }

  static Future _saveKnownWords(List<String> words) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KNOWN_WORDS, jsonEncode(words));
  }
}
