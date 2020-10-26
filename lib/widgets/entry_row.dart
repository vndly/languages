import 'package:Languages/models/player.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:flutter/material.dart';

class EntryRow extends StatelessWidget {
  final String origin;
  final String target;

  const EntryRow({
    @required this.origin,
    @required this.target,
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
        Vocabulary.ORIGIN_LANGUAGE,
        origin,
        Vocabulary.TARGET_LANGUAGE,
        target,
      );
}
