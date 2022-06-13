// ignore_for_file: file_names

import 'package:beefit/constants/AppMethods.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double? width;
  final int? borderRadius;
  final BorderSide? borderSide;

  const CommonButton(
      {Key? key,
      required this.onPressed,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      this.width,
      this.borderRadius,
      this.borderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50 * AppMethods.screenScale(context),
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                fontSize: 17 * AppMethods.fontScale(context),
                fontWeight: FontWeight.w900,
                color: textColor)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius == null
                  ? 15 * AppMethods.screenScale(context)
                  : borderRadius! * AppMethods.screenScale(context))),
          primary: backgroundColor,
        ),
      ),
    );
  }
}
