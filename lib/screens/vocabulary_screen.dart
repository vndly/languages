import 'package:Languages/models/vocabulary.dart';
import 'package:Languages/player/player.dart';
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
        icon: Icons.play_arrow_outlined,
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
    Player.playSingle(Player.SPANISH, widget.expression.spanish);
  }

  @override
  void didUpdateWidget(covariant Content oldWidget) {
    super.didUpdateWidget(oldWidget);
    Player.playSingle(Player.SPANISH, widget.expression.spanish);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpressionText(Player.SPANISH, widget.expression.spanish),
          const SizedBox(height: 20),
          if (hide)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OptionButton(
                  icon: Icons.help_outline,
                  color: Colors.blue,
                  onPressed: _onReveal,
                ),
                const SizedBox(height: 48),
              ],
            )
          else
            ExpressionText(Player.FRENCH, widget.expression.french),
          const SizedBox(height: 50),
          if (!hide)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionButton(
                  icon: Icons.cancel_outlined,
                  color: Colors.red,
                  onPressed: _onBad,
                ),
                const SizedBox(width: 20),
                OptionButton(
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange,
                  onPressed: _onNormal,
                ),
                const SizedBox(width: 20),
                OptionButton(
                  icon: Icons.check,
                  color: Colors.green,
                  onPressed: _onGood,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _onReveal() {
    Player.playSingle(Player.FRENCH, widget.expression.french);
    setState(() {
      hide = false;
    });
  }

  void _onBad() {
    widget.nextExpression();

    setState(() {
      hide = true;
    });
  }

  void _onNormal() {
    widget.nextExpression();

    setState(() {
      hide = true;
    });
  }

  void _onGood() {
    widget.nextExpression();

    setState(() {
      hide = true;
    });
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;

  const OptionButton({
    this.icon,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 80,
      child: RaisedButton(
        color: color,
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 40,
          color: Colors.white,
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
    return InkWell(
      onTap: _onPlay,
      child: Text(
        text,
        style: TextStyle(fontSize: 40, color: Colors.grey[800]),
      ),
    );
  }

  void _onPlay() => Player.playSingle(language, text);
}
