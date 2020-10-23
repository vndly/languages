import 'dart:math';
import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:Languages/json/json_expression.dart';
import 'package:Languages/storage/categories_storage.dart';
import 'package:Languages/storage/known_words_storage.dart';

class Vocabulary {
  final List<JsonCategory> categories;
  final List<JsonExpression> expressions;

  static const String ORIGIN_LANGUAGE = 'es-ES';
  static const String TARGET_LANGUAGE = 'fr-FR';

  Vocabulary(this.categories, this.expressions);

  void fill(List<JsonCategory> newCategories) {
    categories.clear();
    categories.addAll(newCategories);

    expressions.clear();

    for (final JsonCategory category in categories) {
      for (final JsonEntry entry in category.values) {
        expressions.add(JsonExpression(
          category: category.name,
          origin: entry.origin,
          target: entry.target,
        ));
      }
    }
  }

  int get length => categories.length;

  int get size => expressions.length;

  JsonCategory category(int index) => categories[index];

  JsonExpression get randomExpression {
    JsonExpression expression = _randomExpression();

    while (KnownWordsStorage.contains(expression.origin)) {
      expression = _randomExpression();
    }

    return expression;
  }

  JsonExpression _randomExpression() =>
      expressions[Random().nextInt(expressions.length)];

  static Future<Vocabulary> load() async {
    final vocabulary = Vocabulary([], []);

    try {
      final List<JsonCategory> categories = [];

      if (await CategoriesStorage.isEmpty()) {
        final result = await GetCategories()();

        if (result.success) {
          categories.addAll(result.data);
          await CategoriesStorage.save(categories);
        }
      } else {
        categories.addAll(await CategoriesStorage.load());
        _sync(vocabulary);
      }

      vocabulary.fill(categories);
    } catch (e) {
      print(e);
    }

    return vocabulary;
  }

  static Future _sync(Vocabulary vocabulary) async {
    final result = await GetCategories()();

    if (result.success) {
      final List<JsonCategory> categories = result.data;
      vocabulary.fill(categories);
      vocabulary._check();
      CategoriesStorage.save(categories);
    }

    print('Sync completed!');
  }

  void _check() {
    for (final JsonExpression expression in expressions) {
      final occurrencesOrigin =
          _occurrences(Vocabulary.ORIGIN_LANGUAGE, expression.origin);
      final occurrencesTarget =
          _occurrences(Vocabulary.TARGET_LANGUAGE, expression.target);

      if (occurrencesOrigin > 1) {
        print('${expression.category} ${expression.origin}');
      }

      if (occurrencesTarget > 1) {
        print('${expression.category} ${expression.target}');
      }
    }
  }

  int _occurrences(String language, String word) {
    int result = 0;

    if (word.isNotEmpty) {
      for (final JsonExpression expression in expressions) {
        if ((language == Vocabulary.ORIGIN_LANGUAGE) &&
            (expression.origin == word)) {
          result++;
        } else if ((language == Vocabulary.TARGET_LANGUAGE) &&
            (expression.target == word)) {
          result++;
        }
      }
    }

    return result;
  }
}
