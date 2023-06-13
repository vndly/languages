import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Language {
  final Locale locale;

  static const Map<String, String> supportedLanguages = {
    'en-GB': 'English',
    'es-ES': 'Spanish',
    'fr-FR': 'French',
    'it-IT': 'Italian',
    'de-DE': 'German',
    'el-GR': 'Greek',
    'pt-PT': 'Portuguese',
    'ru-RU': 'Russian',
    'ja-JP': 'Japanese',
  };

  const Language(this.locale);

  String get code => locale.toString().replaceAll('_', '-');

  String get name => supportedLanguages[code]!;

  static Future<List<Language>> availableLanguages() async {
    final FlutterTts tts = FlutterTts();
    final List<dynamic> languages = await tts.getLanguages;
    final List<String> languagesFiltered = languages
        .map((l) => l.toString())
        .where((l) => Language.supportedLanguages.keys.contains(l))
        .toList();

    final List<Language> result = languagesFiltered.map((l) {
      final List<String> parts = l.toString().split('-');

      return Language(Locale.fromSubtags(
        languageCode: parts[0],
        countryCode: parts[1],
      ));
    }).toList();

    result.sort((l1, l2) => l1.name.compareTo(l2.name));

    return result;
  }
}
