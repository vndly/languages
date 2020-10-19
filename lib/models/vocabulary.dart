import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vocabulary {
  final List<JsonCategory> categories;

  const Vocabulary(this.categories);

  int get length => categories.length;

  JsonCategory category(int index) => categories[index];

  static Future<Vocabulary> load() async {
    return const Vocabulary([]);
  }

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

  static Future syncData2() async {
    try {
      final result = await GetCategories()();

      if (result.success) {
        for (final JsonCategory category in result.data) {
          final collectionReference = FirebaseFirestore.instance
              .collection('categories')
              .doc(category.name)
              .collection('values');

          for (final JsonEntry entry in category.values) {
            final docReference = collectionReference.doc(entry.es);
            final document = await docReference.get();

            if (document.exists) {
              final data = document.data();

              if (data['fr'] != entry.fr) {
                docReference.update({
                  'fr': entry.fr,
                });
              }
            } else {
              collectionReference.doc(entry.es).set({
                'fr': entry.fr,
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
