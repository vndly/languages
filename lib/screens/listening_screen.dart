import 'package:flutter/material.dart';
import 'package:languages/json/json_expression.dart';
import 'package:languages/models/player.dart';
import 'package:languages/models/vocabulary.dart';
import 'package:languages/widgets/expression_text.dart';
import 'package:languages/widgets/option_button.dart';

class ListeningScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const ListeningScreen(this.vocabulary);

  @override
  _ListeningScreenState createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  JsonExpression? expression;

  @override
  Widget build(BuildContext context) {
    if (expression == null) {
      return Empty(_start);
    } else {
      return Content(widget.vocabulary, expression!, _start, _stop);
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
  final VoidCallback start;

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
  final Vocabulary vocabulary;
  final JsonExpression expression;
  final VoidCallback start;
  final VoidCallback stop;

  const Content(this.vocabulary, this.expression, this.start, this.stop);

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
          ExpressionText(
            widget.vocabulary.originLocale,
            widget.expression.origin,
          ),
          const SizedBox(height: 20),
          ExpressionText(
            widget.vocabulary.targetLocale,
            widget.expression.target,
          ),
          const SizedBox(height: 50),
          OptionButton(
            icon: Icons.stop,
            color: Colors.red,
            onPressed: _onStop,
          ),
        ],
      ),
    );
  }

  void _play() {
    if (playing) {
      Player.playMultiple(
        widget.vocabulary.originLocale,
        widget.expression.origin,
        widget.vocabulary.targetLocale,
        widget.expression.target,
        _onNext,
      );
    }
  }

  void _onNext() {
    if (playing) {
      setState(() {
        widget.start();
      });
    }
  }

  void _onStop() {
    playing = false;
    widget.stop();
  }
}
