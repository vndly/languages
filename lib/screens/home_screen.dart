import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:languages/models/vocabulary.dart';
import 'package:languages/screens/catalogue_screen.dart';
import 'package:languages/screens/listening_screen.dart';
import 'package:languages/screens/settings_screen.dart';
import 'package:languages/screens/vocabulary_screen.dart';

class HomeScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const HomeScreen(this.vocabulary);

  static PageRouteBuilder<HomeScreen> instance(Vocabulary vocabulary) =>
      FadeRoute<HomeScreen>(HomeScreen(vocabulary));

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _page(int position) {
    if (position == 0) {
      return VocabularyScreen(widget.vocabulary);
    } else if (position == 1) {
      return ListeningScreen(widget.vocabulary);
    } else if (position == 2) {
      return CatalogueScreen(widget.vocabulary);
    } else if (position == 3) {
      return SettingsScreen(widget.vocabulary);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over_sharp),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset),
            label: 'Listen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Catalogue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onPageChanged,
      ),
      body: SafeArea(
        child: _page(_selectedIndex),
      ),
    );
  }
}
