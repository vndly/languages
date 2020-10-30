import 'package:Languages/json/json_expression.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/widgets/category_row.dart';
import 'package:Languages/widgets/empty_message.dart';
import 'package:Languages/widgets/entry_row.dart';
import 'package:flutter/material.dart';

class CatalogueScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const CatalogueScreen(this.vocabulary);

  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<JsonExpression> result;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.vocabulary.length == 0) {
      return const EmptyMessage('Empty catalogue');
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              minLines: 1,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.blueGrey,
                          size: 20,
                        ),
                        onPressed: _clear,
                      )
                    : null,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search in ${widget.vocabulary.size} words…',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              onChanged: _search,
            ),
          ),
          if (result == null)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) => CategoryRow(
                  widget.vocabulary,
                  widget.vocabulary.category(position),
                ),
                itemCount: widget.vocabulary.length,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) => EntryRow(
                  vocabulary: widget.vocabulary,
                  origin: result[position].origin,
                  target: result[position].target,
                ),
                itemCount: result.length,
              ),
            )
        ],
      );
    }
  }

  void _search(String text) {
    if (text.isEmpty) {
      setState(() {
        result = null;
      });
    } else {
      setState(() {
        result = widget.vocabulary.search(text);
      });
    }
  }

  void _clear() {
    setState(() {
      controller.text = '';
      _search('');
      FocusScope.of(context).unfocus();
    });
  }
}
