import 'package:languages/storage/known_words_storage.dart';
import 'package:languages/widgets/empty_message.dart';
import 'package:languages/widgets/toolbar.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class KnownWordsScreen extends StatefulWidget {
  final List<String> words;

  const KnownWordsScreen(this.words);

  static PageRouteBuilder<KnownWordsScreen> instance(List<String> words) =>
      RightLeftRoute<KnownWordsScreen>(KnownWordsScreen(words));

  @override
  _KnownWordsScreenState createState() => _KnownWordsScreenState();
}

class _KnownWordsScreenState extends State<KnownWordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Toolbar(title: 'Known words'),
            if (widget.words.isEmpty)
              const Expanded(child: EmptyMessage('Empty list'))
            else
              Content(widget.words, _onRemove),
          ],
        ),
      ),
    );
  }

  void _onRemove(String word) {
    setState(() {
      KnownWordsStorage.remove(word);
      widget.words.remove(word);
    });
  }
}

class Content extends StatelessWidget {
  final List<String> words;
  final Function(String) onRemove;

  const Content(this.words, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          onDismissed: (direction) => onRemove(words[position]),
          child: ListTile(
            title: Text(words[position]),
          ),
        ),
        itemCount: words.length,
      ),
    );
  }
}
