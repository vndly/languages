import 'package:Languages/api/get_categories.dart';
import 'package:Languages/dialogs/dialogs.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_expression.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/screens/expression_list_screen.dart';
import 'package:Languages/screens/known_words_screen.dart';
import 'package:Languages/storage/categories_storage.dart';
import 'package:Languages/storage/known_words_storage.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const SettingsScreen(this.vocabulary);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ButtonDuplicates(widget.vocabulary),
        const Divider(height: 0.5),
        ButtonUntranslated(widget.vocabulary),
        const Divider(height: 0.5),
        ButtonKnownWords(widget.vocabulary),
        const Divider(height: 0.5),
        ButtonSynchronize(widget.vocabulary, _reload),
      ],
    );
  }

  void _reload() => setState(() {});
}

class ButtonDuplicates extends StatelessWidget {
  final Vocabulary vocabulary;

  const ButtonDuplicates(this.vocabulary);

  @override
  Widget build(BuildContext context) {
    final List<JsonExpression> duplicates = vocabulary.duplicates();

    return SettingsRow(
      title: '${duplicates.length} duplicates',
      onTap: () => _onSelected(context, duplicates),
    );
  }

  void _onSelected(
    BuildContext context,
    List<JsonExpression> duplicates,
  ) =>
      Navigator.of(context)
          .push(ExpressionListScreen.instance('Duplicates', duplicates));
}

class ButtonUntranslated extends StatelessWidget {
  final Vocabulary vocabulary;

  const ButtonUntranslated(this.vocabulary);

  @override
  Widget build(BuildContext context) {
    final List<JsonExpression> untranslated = vocabulary.untranslated();

    return SettingsRow(
      title: '${untranslated.length} untranslated',
      onTap: () => _onSelected(context, untranslated),
    );
  }

  void _onSelected(
    BuildContext context,
    List<JsonExpression> untranslated,
  ) =>
      Navigator.of(context)
          .push(ExpressionListScreen.instance('Untranslated', untranslated));
}

class ButtonKnownWords extends StatefulWidget {
  final Vocabulary vocabulary;

  const ButtonKnownWords(this.vocabulary);

  @override
  _ButtonKnownWordsState createState() => _ButtonKnownWordsState();
}

class _ButtonKnownWordsState extends State<ButtonKnownWords> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: KnownWordsStorage.load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SettingsRow(
              title: '${snapshot.data.length} known words',
              onTap: () => _onSelected(context, snapshot.data),
            );
          } else {
            return const SettingsRow(
              title: '0 known words',
            );
          }
        });
  }

  Future _onSelected(
    BuildContext context,
    List<String> knownWords,
  ) async {
    await Navigator.of(context).push(KnownWordsScreen.instance(knownWords));
    setState(() {});
  }
}

class ButtonSynchronize extends StatelessWidget {
  final Vocabulary vocabulary;
  final Function reload;

  const ButtonSynchronize(this.vocabulary, this.reload);

  @override
  Widget build(BuildContext context) {
    return SettingsRow(
      title: 'Synchronize',
      onTap: () => _onSelected(context),
      showArrow: false,
    );
  }

  Future _onSelected(BuildContext context) async {
    final dialog =
        await Dialogs.showLoadingDialog(context, 'Downloading data...');

    final result = await GetCategories()();

    Navigator.of(dialog).pop();

    if (result.success) {
      final List<JsonCategory> categories = result.data;
      vocabulary.fill(categories);
      CategoriesStorage.save(categories);
      reload();
    } else {
      Dialogs.showErrorDialog(context, 'Error downloading data');
    }
  }
}

class SettingsRow extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool showArrow;

  const SettingsRow({
    this.title,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: showArrow
          ? const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 12,
            )
          : null,
      onTap: onTap,
    );
  }
}
