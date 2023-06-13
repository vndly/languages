import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color color;
  final VoidCallback onPressed;

  const OptionButton({
    required this.color,
    required this.onPressed,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: (icon != null)
                ? Icon(
                    icon,
                    size: 40,
                    color: Colors.white,
                  )
                : Text(
                    text!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
          )),
    );
  }
}
