import 'package:Languages/storage/known_words_storage.dart';
import 'package:Languages/widgets/toolbar.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class KnownWordsScreen extends StatelessWidget {
  final List<String> words;

  const KnownWordsScreen(this.words);

  static PageRouteBuilder<KnownWordsScreen> instance(List<String> words) =>
      RightLeftRoute<KnownWordsScreen>(KnownWordsScreen(words));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Toolbar(title: 'Known words'),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) => Dismissible(
                  key: Key(words[position]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          'Remove',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) => _onRemove(words[position]),
                  child: ListTile(
                    title: Text(words[position]),
                  ),
                ),
                itemCount: words.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRemove(String word) => KnownWordsStorage.remove(word);
}
