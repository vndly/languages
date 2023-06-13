import 'package:flutter/material.dart';
import 'package:languages/screens/splash_screen.dart';
import 'package:wakelock/wakelock.dart';

class LanguageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
