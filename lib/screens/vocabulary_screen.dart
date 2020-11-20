import 'package:Languages/json/json_expression.dart';
import 'package:Languages/storage/known_words_storage.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/models/player.dart';
import 'package:Languages/widgets/expression_text.dart';
import 'package:Languages/widgets/option_button.dart';
import 'package:flutter/material.dart';

// TODO(momo): Don't repeat words in the same session
// TODO(momo): Remove all duplicated
class VocabularyScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const VocabularyScreen(this.vocabulary);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  JsonExpression expression;

  @override
  Widget build(BuildContext context) {
    if (expression == null) {
      return Empty(_nextExpression);
    } else {
      return Content(widget.vocabulary, expression, _nextExpression);
    }
  }

  void _nextExpression() {
    setState(() {
      expression = widget.vocabulary.randomExpression;
    });
  }
}

class Empty extends StatelessWidget {
  final Function nextExpression;

  const Empty(this.nextExpression);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OptionButton(
        icon: Icons.play_arrow,
        color: Colors.blue,
        onPressed: _onStart,
      ),
    );
  }

  void _onStart() => nextExpression();
}

class Content extends StatefulWidget {
  final Vocabulary vocabulary;
  final JsonExpression expression;
  final Function nextExpression;

  const Content(this.vocabulary, this.expression, this.nextExpression);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool hide = true;

  @override
  void initState() {
    super.initState();
    Player.playSingle(widget.vocabulary.originLocale, widget.expression.origin);
  }

  @override
  void didUpdateWidget(covariant Content oldWidget) {
    super.didUpdateWidget(oldWidget);
    Player.playSingle(widget.vocabulary.originLocale, widget.expression.origin);
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
          if (hide)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                OptionButton(
                  text: '?',
                  color: Colors.blue,
                  onPressed: _onReveal,
                ),
                const SizedBox(height: 21),
              ],
            )
          else
            ExpressionText(
              widget.vocabulary.targetLocale,
              widget.expression.target,
            ),
          const SizedBox(height: 50),
          if (!hide)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  onPressed: _onIncorrect,
                ),
                const SizedBox(width: 20),
                OptionButton(
                  icon: Icons.check,
                  color: Colors.green,
                  onPressed: _onCorrect,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _onReveal() {
    Player.playSingle(widget.vocabulary.targetLocale, widget.expression.target);
    setState(() {
      hide = false;
    });
  }

  void _onIncorrect() {
    setState(() {
      hide = true;
    });

    widget.nextExpression();
  }

  Future _onCorrect() async {
    await KnownWordsStorage.add(widget.expression.origin);

    setState(() {
      hide = true;
    });

    widget.nextExpression();
  }
}
