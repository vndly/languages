import 'package:Languages/json/json_expression.dart';
import 'package:Languages/widgets/toolbar.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class ExpressionListScreen extends StatelessWidget {
  final String title;
  final List<JsonExpression> expressions;

  const ExpressionListScreen(this.title, this.expressions);

  static PageRouteBuilder<ExpressionListScreen> instance(
    String title,
    List<JsonExpression> expressions,
  ) =>
      RightLeftRoute<ExpressionListScreen>(
          ExpressionListScreen(title, expressions));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Toolbar(title: title),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) => ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(expressions[position].origin)),
                      Expanded(child: Text(expressions[position].target)),
                    ],
                  ),
                ),
                itemCount: expressions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
