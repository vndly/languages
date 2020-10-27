import 'package:Languages/screens/setup_screen.dart';
import 'package:Languages/storage/known_words_storage.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/screens/home_screen.dart';
import 'package:Languages/storage/profile_storage.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

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
    InitCallback.register(_init);
  }

  Future _init() async {
    await KnownWordsStorage.init();

    if (await ProfileStorage.isEmpty()) {
      Navigator.of(context).pushReplacement(SetupScreen.instance());
    } else {
      final Vocabulary vocabulary = await Vocabulary.load();
      Navigator.of(context).pushReplacement(HomeScren.instance(vocabulary));
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
