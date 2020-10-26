import 'package:Languages/json/json_expression.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/models/player.dart';
import 'package:Languages/widgets/expression_text.dart';
import 'package:Languages/widgets/option_button.dart';
import 'package:flutter/material.dart';

class ListeningScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const ListeningScreen(this.vocabulary);

  @override
  _ListeningScreenState createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  JsonExpression expression;

  @override
  Widget build(BuildContext context) {
    if (expression == null) {
      return Empty(_start);
    } else {
      return Content(expression, _start, _stop);
    }
  }

  void _start() {
    setState(() {
      expression = widget.vocabulary.randomExpression;
    });
  }

  void _stop() {
    setState(() {
      expression = null;
    });
  }
}

class Empty extends StatelessWidget {
  final Function start;

  const Empty(this.start);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OptionButton(
        icon: Icons.play_arrow,
        color: Colors.blue,
        onPressed: start,
      ),
    );
  }
}

class Content extends StatefulWidget {
  final JsonExpression expression;
  final Function start;
  final Function stop;

  const Content(this.expression, this.start, this.stop);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool playing = true;

  @override
  void initState() {
    super.initState();
    _play();
  }

  @override
  void didUpdateWidget(covariant Content oldWidget) {
    super.didUpdateWidget(oldWidget);
    _play();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpressionText(Vocabulary.ORIGIN_LANGUAGE, widget.expression.origin),
          const SizedBox(height: 20),
          ExpressionText(Vocabulary.TARGET_LANGUAGE, widget.expression.target),
          const SizedBox(height: 50),
          OptionButton(
            icon: Icons.stop,
            color: Colors.red,
            onPressed: widget.stop,
          ),
        ],
      ),
    );
  }

  void _play() {
    if (playing) {
      Player.playMultiple(
        Vocabulary.ORIGIN_LANGUAGE,
        widget.expression.origin,
        Vocabulary.TARGET_LANGUAGE,
        widget.expression.target,
        _onNext,
      );
    }
  }

  void _onNext() {
    setState(() {
      widget.start();
    });
  }
}
