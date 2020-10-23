import 'package:Languages/models/known_words.dart';
import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/models/player.dart';
import 'package:flutter/material.dart';

class VocabularyScreen extends StatefulWidget {
  final Vocabulary vocabulary;

  const VocabularyScreen(this.vocabulary);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  Expression expression;

  @override
  Widget build(BuildContext context) {
    if (expression == null) {
      return Empty(_nextExpression);
    } else {
      return Content(expression, _nextExpression);
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
  final Expression expression;
  final Function nextExpression;

  const Content(this.expression, this.nextExpression);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool hide = true;

  @override
  void initState() {
    super.initState();
    Player.playSingle(Player.ORIGIN_LANGUAGE, widget.expression.origin);
  }

  @override
  void didUpdateWidget(covariant Content oldWidget) {
    super.didUpdateWidget(oldWidget);
    Player.playSingle(Player.ORIGIN_LANGUAGE, widget.expression.origin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpressionText(Player.ORIGIN_LANGUAGE, widget.expression.origin),
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
            ExpressionText(Player.TARGET_LANGUAGE, widget.expression.target),
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
    Player.playSingle(Player.TARGET_LANGUAGE, widget.expression.target);
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
    await KnownWords.add(widget.expression.origin);

    setState(() {
      hide = true;
    });

    widget.nextExpression();
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Function onPressed;

  const OptionButton({
    this.icon,
    this.text,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 85,
      child: RaisedButton(
        color: color,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        child: (icon != null)
            ? Icon(
                icon,
                size: 40,
                color: Colors.white,
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
      ),
    );
  }
}

class ExpressionText extends StatelessWidget {
  final String language;
  final String text;

  const ExpressionText(this.language, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: _onPlay,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }

  void _onPlay() => Player.playSingle(language, text);
}
