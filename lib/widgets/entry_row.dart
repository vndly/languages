import 'package:flutter/material.dart';
import 'package:languages/models/player.dart';
import 'package:languages/models/vocabulary.dart';

class EntryRow extends StatelessWidget {
  final Vocabulary vocabulary;
  final String origin;
  final String target;

  const EntryRow({
    required this.vocabulary,
    required this.origin,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(origin)),
          Expanded(child: Text(target)),
        ],
      ),
      onTap: _onSelected,
    );
  }

  void _onSelected() => Player.playMultiple(
        vocabulary.originLocale,
        origin,
        vocabulary.targetLocale,
        target,
        () {},
      );
}
