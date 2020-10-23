import 'dart:math';

import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:Languages/models/known_words.dart';
import 'package:Languages/models/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vocabulary {
  final List<JsonCategory> categories;
  final List<Expression> expressions;

  const Vocabulary(this.categories, this.expressions);

  int get length => categories.length;

  JsonCategory category(int index) => categories[index];

  Expression get randomExpression {
    Expression expression = _randomExpression();

    while (KnownWords.contains(expression.spanish)) {
      expression = _randomExpression();
    }

    return expression;
  }

  Expression _randomExpression() =>
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
          final String spanish = entry.key;
          final String french = entry.value.toString();

          if (spanish.isNotEmpty && french.isNotEmpty) {
            entries.add(JsonEntry(es: spanish, fr: french));
            expressions.add(Expression(
              category: doc.id,
              spanish: spanish,
              french: french,
            ));
          }
        }

        categories.add(JsonCategory(name: doc.id, values: entries));
      }
    } catch (e) {
      print(e);
    }

    final vocabulary = Vocabulary(categories, expressions);
    vocabulary._check();

    return vocabulary;
  }

  void _check() {
    for (final Expression expression in expressions) {
      final occurrencesSpanish =
          _occurrences(Player.SPANISH, expression.spanish);
      final occurrencesFrench = _occurrences(Player.FRENCH, expression.french);

      if (occurrencesSpanish > 1) {
        print('${expression.category} ${expression.spanish}');
      }

      if (occurrencesFrench > 1) {
        print('${expression.category} ${expression.french}');
      }
    }
  }

  int _occurrences(String language, String word) {
    int result = 0;

    if (word.isNotEmpty) {
      for (final Expression expression in expressions) {
        if ((language == Player.SPANISH) && (expression.spanish == word)) {
          result++;
        } else if ((language == Player.FRENCH) && (expression.french == word)) {
          result++;
        }
      }
    }

    return result;
  }

  static Future syncData() async {
    try {
      final result = await GetCategories()();

      if (result.success) {
        final collectionReference =
            FirebaseFirestore.instance.collection('categories');

        for (final JsonCategory category in result.data) {
          final document = collectionReference.doc(category.name);
          final data = <String, String>{};

          for (final JsonEntry entry in category.values) {
            data[entry.es.replaceAll('/', '-')] = entry.fr;
          }

          await document.set(data);
        }

        print('Sync completed!');
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
