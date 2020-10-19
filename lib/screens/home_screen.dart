import 'package:Languages/json/json_category.dart';
import 'package:Languages/screens/catalogue_screen.dart';
import 'package:Languages/screens/vocabulary_screen.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class HomeScren extends StatefulWidget {
  final List<JsonCategory> categories;

  const HomeScren(this.categories);

  static PageRouteBuilder<HomeScren> instance(List<JsonCategory> categories) =>
      FadeRoute<HomeScren>(HomeScren(categories));

  @override
  _HomeScrenState createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _page(int position) {
    if (position == 0) {
      return const VocabularyScreen();
    } else if (position == 1) {
      return CatalogueScreen(widget.categories);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.record_voice_over_sharp),
              label: 'Vocabulary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Catalogue',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onPageChanged,
        ),
        body: SafeArea(
          child: _page(_selectedIndex),
        ),
      ),
    );
  }
}
