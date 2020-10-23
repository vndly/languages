import 'package:Languages/json/json_entry.dart';
import 'package:Languages/models/player.dart';
import 'package:flutter/material.dart';

class EntryRow extends StatelessWidget {
  final JsonEntry entry;

  const EntryRow(this.entry);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(entry.es)),
          Expanded(child: Text(entry.fr)),
        ],
      ),
      onTap: _onSelected,
    );
  }

  void _onSelected() =>
      Player.playMultiple('es-ES', entry.es, 'fr-FR', entry.fr);
}
