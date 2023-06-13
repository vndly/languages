import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:languages/models/vocabulary.dart';
import 'package:languages/screens/home_screen.dart';
import 'package:languages/screens/setup_screen.dart';
import 'package:languages/storage/known_words_storage.dart';
import 'package:languages/storage/profile_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  static PageRouteBuilder<SplashScreen> instance() =>
      FadeRoute<SplashScreen>(const SplashScreen());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Delayed.post(_init);
  }

  Future _init() async {
    await KnownWordsStorage.init();

    if (await ProfileStorage.isEmpty()) {
      Navigator.of(context).pushReplacement(SetupScreen.instance());
    } else {
      final Vocabulary vocabulary = await Vocabulary.load();
      Navigator.of(context).pushReplacement(HomeScreen.instance(vocabulary));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LightStatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
