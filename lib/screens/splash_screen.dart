import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/screens/home_screen.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_core/firebase_core.dart';
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
      await Firebase.initializeApp();
      final vocabulary = await Vocabulary.load();
      Navigator.of(context).pushReplacement(HomeScren.instance(vocabulary));
      Vocabulary.syncData();
    } catch (e) {
      print(e);
      _showError();
    }
  }

  void _showError() => _scaffoldKey.currentState.showSnackBar(const SnackBar(
        content: Text('Error downloading data'),
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
