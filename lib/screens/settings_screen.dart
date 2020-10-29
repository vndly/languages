import 'package:Languages/json/json_expression.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Vocabulary vocabulary;

  const SettingsScreen(this.vocabulary);

  @override
  Widget build(BuildContext context) {
    final List<JsonExpression> duplicates = vocabulary.duplicates();
    final List<JsonExpression> untranslated = vocabulary.untranslated();

    return Column(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        ListTile(
          title: Text('${duplicates.length} duplicates'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 12,
          ),
          onTap: () => _onSeeDuplicates(duplicates),
        ),
        const Divider(),
        ListTile(
          title: Text('${untranslated.length} untranslated'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 12,
          ),
          onTap: () => _onSeeUntranslated(untranslated),
        ),
      ],
    );
  }

  void _onSeeDuplicates(List<JsonExpression> duplicates) {}

  void _onSeeUntranslated(List<JsonExpression> untranslated) {}
}
