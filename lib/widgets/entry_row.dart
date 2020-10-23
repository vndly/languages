import 'package:Languages/json/json_entry.dart';
import 'package:Languages/models/player.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:flutter/material.dart';

class EntryRow extends StatelessWidget {
  final JsonEntry entry;

  const EntryRow(this.entry);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(entry.origin)),
          Expanded(child: Text(entry.target)),
        ],
      ),
      onTap: _onSelected,
    );
  }

  void _onSelected() => Player.playMultiple(
        Vocabulary.ORIGIN_LANGUAGE,
        entry.origin,
        Vocabulary.TARGET_LANGUAGE,
        entry.target,
      );
}
