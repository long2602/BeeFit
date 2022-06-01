import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:beefit/constants/app_style.dart';
import 'package:beefit/screens/get_started_screen.dart';
import 'package:beefit/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeeFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset("assets/imgs/bee 1.png"),
            const SizedBox(width: 10),
            const Text(
              "BeeFit",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            )
          ],
        ),
        nextScreen: const OnboardingScreen(),
        backgroundColor: AppStyle.primaryColor,
        duration: 2500,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
