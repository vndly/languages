import 'package:languages/screens/splash_screen.dart';
import 'package:flutter/material.dart';

// Check if word is duplicated
// Add exercise to check if you remember the word. If so, make it less frequent to appear
class LanguageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
