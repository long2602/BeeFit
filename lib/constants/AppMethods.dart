// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppMethods {
  static const String NAME = 'name';
  static const String LEVEL = 'level';
  static const String CURRENT_WEIGHT = 'currentWeight';
  static const String AGE = 'age';
  static const String HEIGHT = 'height';
  static const String IS_MALE = 'isMale';
  static const String BMI = 'bmi';
  static const String BMR = 'bmr';
  static const String GOAL = 'goal';
  static const String MUSCLES = 'muscle';
  static const String MAINPLAN = 'mainplan';
  static const String Is_FIRSTTIME = 'firstTime';

  //calculate met
  static num calculateMet(
      int weight, int rep, int duration, int isRepCount, int met) {
    return met *
        weight *
        (isRepCount == 0 ? (duration / 60) : (rep * 2 / 60)) *
        0.0175;
  }

  //Convert hexColor to int
  static int hexColor(String a) {
    String newColor = '0xff' + a;
    newColor = newColor.replaceAll('#', '');
    return int.parse(newColor);
  }

  //Calculate the screen scale
  static double screenScale(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    double hScale = 0, wScale = 0;
    if (orientation == Orientation.portrait) {
      hScale = screenSize.height / 891.4286;
      wScale = screenSize.width / 411.4286;
    } else {
      hScale = screenSize.height / 411.4286;
      wScale = screenSize.width / 891.4286;
    }
    return (hScale + wScale) / 2;
  }

  //Scale for font
  static double fontScale(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    double fScale = 0;

    if (orientation == Orientation.portrait) {
      fScale = screenSize.width / 411.4286;
    } else {
      fScale = screenSize.width / 891.4286;
    }

    return fScale;
  }

  //Animated page route
  static PageRouteBuilder<dynamic> animatedRoute(Widget destination) {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secAnimation, Widget child) {
          return SlideTransition(
            child: child,
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secAnimation) {
          return destination;
        });
  }
}
