// ignore_for_file: file_names

import 'package:beefit/constants/AppStyles.dart';
import 'package:flutter/material.dart';

class ButtonTag extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _backgroundColor;
  final String _text;
  final Color _textColor;

  const ButtonTag(
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
    return TextButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(_backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: AppStyle.appBorder,
            ),
          ),
        ),
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 14,
            color: _textColor,
          ),
        ));
  }
}
