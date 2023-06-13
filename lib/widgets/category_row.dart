import 'package:flutter/material.dart';
import 'package:languages/json/json_category.dart';
import 'package:languages/models/vocabulary.dart';
import 'package:languages/screens/category_screen.dart';

class CategoryRow extends StatelessWidget {
  final Vocabulary vocabulary;
  final JsonCategory category;

  const CategoryRow(this.vocabulary, this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      onTap: () => _onSelected(context),
    );
  }

  void _onSelected(BuildContext context) =>
      Navigator.of(context).push(CategoryScreen.instance(vocabulary, category));
}
