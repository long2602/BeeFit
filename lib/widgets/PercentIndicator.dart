// ignore_for_file: file_names

import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/constants/AppMethods.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentIndicator extends StatefulWidget {
  const PercentIndicator({Key? key}) : super(key: key);

  @override
  State<PercentIndicator> createState() => _PercentIndicatorState();
}

class _PercentIndicatorState extends State<PercentIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 112.5 * AppMethods.screenScale(context),
      lineWidth: 30.0,
      animation: true,
      percent: 0.7,
      center: Text(
        "70.0%",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: (40.0 * AppMethods.fontScale(context)),
            color: AppStyle.primaryColor),
      ),
      backgroundColor: const Color(0xffebebeb),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppStyle.primaryColor,
    );
  }
}
