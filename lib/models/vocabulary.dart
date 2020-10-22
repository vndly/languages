import 'dart:math';

import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vocabulary {
  final List<JsonCategory> categories;
  final List<Expression> expressions;

  const Vocabulary(this.categories, this.expressions);

  int get length => categories.length;

  JsonCategory category(int index) => categories[index];

  Expression get randomExpression =>
      expressions[Random().nextInt(expressions.length)];

  static Future<Vocabulary> load() async {
    final List<JsonCategory> categories = [];
    final List<Expression> expressions = [];

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      for (final doc in querySnapshot.docs) {
        final List<JsonEntry> entries = [];
        final data = doc.data();

        for (final MapEntry<String, dynamic> entry in data.entries) {
          entries.add(JsonEntry(es: entry.key, fr: entry.value.toString()));
          expressions.add(Expression(
            category: doc.id,
            spanish: entry.key,
            french: entry.value.toString(),
          ));
        }

        categories.add(JsonCategory(name: doc.id, values: entries));
      }
    } catch (e) {
      print(e);
    }

    final vocabulary = Vocabulary(categories, expressions);
    vocabulary.check();

    return vocabulary;
  }

  void check() {}

  static Future syncData() async {
    try {
      final result = await GetCategories()();

      if (result.success) {
        final collectionReference =
            FirebaseFirestore.instance.collection('categories');

        for (final JsonCategory category in result.data) {
          final document = collectionReference.doc(category.name);
          final documentSnapshot = await document.get();
          final data = <String, String>{};

          if (documentSnapshot.exists) {
            final map = documentSnapshot
                .data()
                .map((key, value) => MapEntry(key, value.toString()));
            data.addAll(map);
          }

          for (final JsonEntry entry in category.values) {
            data[entry.es.replaceAll('/', '-')] = entry.fr;
          }

          if (documentSnapshot.exists) {
            await document.update(data);
          } else {
            await document.set(data);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

class Expression {
  final String category;
  final String spanish;
  final String french;

  const Expression({
    this.category,
    this.spanish,
    this.french,
  });
}
