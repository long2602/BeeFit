// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _backgroundColor;
  final String _text;
  final Color _textColor;
  final double? _height;
  final double? _width;

  const ButtonMain(
      {Key? key,
      required VoidCallback onPressed,
      required Color backgroundColor,
      required String text,
      required Color textColor,
      double? height,
      double? width})
      : _backgroundColor = backgroundColor,
        _onPressed = onPressed,
        _text = text,
        _textColor = textColor,
        _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onPressed,
        child: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _backgroundColor),
          child: Center(
            child: Text(
              _text,
              style: TextStyle(
                  color: _textColor, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
