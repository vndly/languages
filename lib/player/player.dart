import 'package:flutter_tts/flutter_tts.dart';

class Player {
  static final FlutterTts tts = FlutterTts();
  static PlayerState state = PlayerState.PLAYING_1;

  static const String SPANISH = 'es-ES';
  static const String FRENCH = 'fr-FR';

  static Future play2(
    String language1,
    String text1,
    String language2,
    String text2,
    Function onComplete,
  ) async {
    tts.setCompletionHandler(() async {
      switch (state) {
        case PlayerState.PLAYING_1:
          state = PlayerState.PLAYING_2;
          //await Future.delayed(const Duration(seconds: 1));
          _speak(language2, text2);
          break;

        case PlayerState.PLAYING_2:
          state = PlayerState.PLAYING_1;
          onComplete();
          break;
      }
    });

    await _speak(language1, text1);
  }

  static Future play(
    String language,
    String text,
  ) =>
      _speak(language, text);

  static Future _speak(String language, String text) async {
    if (text.isNotEmpty) {
      await tts.setLanguage(language);
      await tts.speak(text);
    }
  }
}

enum PlayerState {
  PLAYING_1,
  PLAYING_2,
}
