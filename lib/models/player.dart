import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Player {
  static final FlutterTts tts = FlutterTts();
  static PlayerState state = PlayerState.PLAYING_ORIGIN;

  static Future playMultiple(
    String language1,
    String text1,
    String language2,
    String text2,
    VoidCallback onComplete,
  ) async {
    tts.setCompletionHandler(() async {
      switch (state) {
        case PlayerState.PLAYING_ORIGIN:
          state = PlayerState.PLAYING_TARGET;
          _speak(language2, text2);
          break;

        case PlayerState.PLAYING_TARGET:
          state = PlayerState.PLAYING_ORIGIN;
          onComplete();
          break;
      }
    });

    await _speak(language1, text1);
  }

  static Future playSingle(String language, String text) =>
      _speak(language, text);

  static Future _speak(String language, String text) async {
    if (text.isNotEmpty) {
      await tts.setLanguage(language);
      await tts.speak(text);
    }
  }
}

enum PlayerState {
  PLAYING_ORIGIN,
  PLAYING_TARGET,
}
