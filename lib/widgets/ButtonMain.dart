import 'package:beefit/constants/app_style.dart';
import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _backgroundColor;
  final String _text;
  final Color _textColor;

  const ButtonMain(
      {Key? key,
      required VoidCallback onPressed,
      required Color backgroundColor,
      required String text,
      required Color textColor})
      : _backgroundColor = backgroundColor,
        _onPressed = onPressed,
        _text = text,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onPressed,
        child: Container(
          height: 60,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: _backgroundColor,
          ),
          child: Center(
            child: Text(
              _text,
              style: TextStyle(
                color: _textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
