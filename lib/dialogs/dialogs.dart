import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<BuildContext> showLoadingDialog(
      BuildContext context, String message) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            contentPadding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Column(children: [
                  const CircularProgressIndicator(),
                  const VBox(20),
                  Text(message)
                ]),
              )
            ],
          ),
        );
      },
    );

    return context;
  }

  static Future<BuildContext> showErrorDialog(
    BuildContext context,
    String error,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(30),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok'.toUpperCase()),
              ),
            ],
          ),
        );
      },
    );

    return context;
  }
}
