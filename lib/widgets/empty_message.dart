import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final String title;

  const EmptyMessage(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
