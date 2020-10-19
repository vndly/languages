import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/screens/home_screen.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

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
    final result = await GetCategories()();

    if (result.success) {
      Navigator.of(context).pushReplacement(HomeScren.instance(result.data));
    } else {
      // error
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
