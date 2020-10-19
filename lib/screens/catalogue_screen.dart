import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:Languages/widgets/category_row.dart';
import 'package:Languages/widgets/entry_row.dart';
import 'package:flutter/material.dart';

class CatalogueScreen extends StatefulWidget {
  final List<JsonCategory> categories;

  const CatalogueScreen(this.categories);

  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<JsonEntry> result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            minLines: 1,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffeeeeee),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: _search,
          ),
        ),
        if (result == null)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) =>
                  CategoryRow(widget.categories[position]),
              itemCount: widget.categories.length,
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) => EntryRow(result[position]),
              itemCount: result.length,
            ),
          )
      ],
    );
  }

  void _search(String text) {
    if (text.isEmpty) {
      setState(() {
        result = null;
      });
    } else {
      final List<JsonEntry> entries = [];

      for (final JsonCategory category in widget.categories) {
        for (final JsonEntry entry in category.values) {
          if (entry.matches(text)) {
            entries.add(entry);
          }
        }
      }

      setState(() {
        result = entries;
      });
    }
  }
}
