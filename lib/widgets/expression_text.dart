import 'package:languages/models/player.dart';
import 'package:flutter/material.dart';

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
