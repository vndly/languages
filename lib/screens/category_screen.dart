import 'package:Languages/json/json_category.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/widgets/empty_message.dart';
import 'package:Languages/widgets/entry_row.dart';
import 'package:Languages/widgets/toolbar.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final Vocabulary vocabulary;
  final JsonCategory category;

  const CategoryScreen(this.vocabulary, this.category);

  static PageRouteBuilder<CategoryScreen> instance(
    Vocabulary vocabulary,
    JsonCategory category,
  ) =>
      RightLeftRoute<CategoryScreen>(CategoryScreen(vocabulary, category));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Toolbar(title: category.name),
            if (category.values.isEmpty)
              const Expanded(child: EmptyMessage('Empty list'))
            else
              Content(vocabulary, category),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final Vocabulary vocabulary;
  final JsonCategory category;

  const Content(this.vocabulary, this.category);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, position) => EntryRow(
          vocabulary: vocabulary,
          origin: category.values[position].origin,
          target: category.values[position].target,
        ),
        itemCount: category.values.length,
      ),
    );
  }
}
