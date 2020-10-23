import 'package:Languages/storage/known_words_storage.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/screens/home_screen.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    InitCallback.register(_init);
  }

  Future _init() async {
    try {
      await KnownWordsStorage.init();
      final Vocabulary vocabulary = await Vocabulary.load();
      Navigator.of(context).pushReplacement(HomeScren.instance(vocabulary));
    } catch (e) {
      _showError(e);
    }
  }

  void _showError(Exception e) =>
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Scaffold(
        key: _scaffoldKey,
        body: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
