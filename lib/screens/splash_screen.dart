import 'package:Languages/api/categories/get_categories.dart';
import 'package:Languages/json/json_category.dart';
import 'package:Languages/json/json_entry.dart';
import 'package:Languages/screens/home_screen.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    InitCallback.register(_init);
  }

  Future _init() async {
    try {
      await Firebase.initializeApp();

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

            /*final snapshot =
                await reference.where('es', isEqualTo: entry.es).get();

            if (snapshot.size == 1) {
              final document = snapshot.docs[0];
              reference.doc(document.id).update({
                'fr': entry.fr,
              });
            } else {
              reference.add({
                'fr': entry.fr,
              });
            }*/
          }
        }

        Navigator.of(context).pushReplacement(HomeScren.instance(result.data));
      } else {
        _showError();
      }
    } catch (e) {
      print(e);
      _showError();
    }
  }

  void _showError() => _scaffoldKey.currentState.showSnackBar(const SnackBar(
        content: Text('Error downloading data'),
      ));

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Scaffold(
        key: _scaffoldKey,
        body: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
