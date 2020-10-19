import 'package:Languages/json/json_category.dart';
import 'package:Languages/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final JsonCategory category;

  const CategoryRow(this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      onTap: () => _onSelected(context),
    );
  }

  void _onSelected(BuildContext context) =>
      Navigator.of(context).push(CategoryScreen.instance(category));
}