import 'dart:math';
import 'package:languages/api/get_categories.dart';
import 'package:languages/json/json_category.dart';
import 'package:languages/json/json_entry.dart';
import 'package:languages/json/json_expression.dart';
import 'package:languages/json/json_profile.dart';
import 'package:languages/storage/categories_storage.dart';
import 'package:languages/storage/known_words_storage.dart';
import 'package:languages/storage/profile_storage.dart';

class Vocabulary {
  final List<JsonCategory> categories;
  final List<JsonExpression> expressions;
  final String originLocale;
  final String targetLocale;

  Vocabulary(
    this.categories,
    this.expressions,
    this.originLocale,
    this.targetLocale,
  );

  void fill(List<JsonCategory> newCategories) {
    categories.clear();
    categories.addAll(newCategories);
    categories.sort((c1, c2) => c1.name.compareTo(c2.name));

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

    expressions.sort((e1, e2) => e1.origin.compareTo(e2.origin));
  }

  int get length => categories.length;

  int get size => expressions.length;

  JsonCategory category(int index) => categories[index];

  List<JsonExpression> search(String query) {
    final List<JsonExpression> result = [];

    for (final JsonExpression entry in expressions) {
      if (entry.matches(query)) {
        result.add(entry);
      }
    }

    result.sort((e1, e2) => e1.origin.compareTo(e2.origin));

    return result;
  }

  JsonExpression get randomExpression {
    JsonExpression expression = _randomExpression();

    while (KnownWordsStorage.contains(expression.origin) ||
        !expression.isNotEmpty) {
      expression = _randomExpression();
    }

    return expression;
  }

  JsonExpression _randomExpression() =>
      expressions[Random().nextInt(expressions.length)];

  static Future<Vocabulary> load() async {
    final JsonProfile profile = await ProfileStorage.load();

    final vocabulary = Vocabulary(
      [],
      [],
      profile.origin,
      profile.target,
    );

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
      CategoriesStorage.save(categories);
    }

    print('Sync completed!');
  }

  List<JsonExpression> duplicates() {
    final List<JsonExpression> result = [];

    for (final JsonExpression expression in expressions) {
      final occurrencesOrigin = _occurrences(originLocale, expression.origin);
      final occurrencesTarget = _occurrences(targetLocale, expression.target);

      if ((occurrencesOrigin > 1) || (occurrencesTarget > 1)) {
        result.add(expression);
      }
    }

    result.sort((e1, e2) => e1.origin.compareTo(e2.origin));

    return result;
  }

  List<JsonExpression> untranslated() {
    final List<JsonExpression> result = [];

    for (final JsonExpression expression in expressions) {
      if (!expression.isNotEmpty) {
        result.add(expression);
      }
    }

    result.sort((e1, e2) => e1.origin.compareTo(e2.origin));

    return result;
  }

  int _occurrences(String language, String word) {
    int result = 0;

    if (word.isNotEmpty) {
      for (final JsonExpression expression in expressions) {
        if ((language == originLocale) && (expression.origin == word)) {
          result++;
        } else if ((language == targetLocale) && (expression.target == word)) {
          result++;
        }
      }
    }

    return result;
  }
}
