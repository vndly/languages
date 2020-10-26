import 'package:Languages/json/json_category.dart';
import 'package:Languages/widgets/entry_row.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final JsonCategory category;

  const CategoryScreen(this.category);

  static PageRouteBuilder<CategoryScreen> instance(JsonCategory category) =>
      RightLeftRoute<CategoryScreen>(CategoryScreen(category));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Toolbar(title: category.name),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) => EntryRow(
                  origin: category.values[position].origin,
                  target: category.values[position].target,
                ),
                itemCount: category.values.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Toolbar extends StatelessWidget {
  final String title;

  const Toolbar({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
        color: Colors.white,
      ),
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
