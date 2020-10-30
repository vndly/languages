import 'package:flutter/material.dart';

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
      height: 100,
      minWidth: 100,
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
