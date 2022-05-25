import 'package:flutter/material.dart';

class AppUI {
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
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secAnimation, Widget child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
          return ScaleTransition(
            scale: animation,
            child: child,
            alignment: Alignment.center,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secAnimation) {
          return destination;
        });
  }
}
