import 'dart:ffi';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:beefit/constants/app_style.dart';
import 'package:beefit/screens/AppScreen.dart';
import 'package:beefit/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool("firstTime") ?? false;
  runApp(MyApp(isFirstTime: isFirstTime,));
}

class MyApp extends StatelessWidget {
  bool isFirstTime;
  MyApp({Key? key, required  this.isFirstTime}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
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
        nextScreen: isFirstTime? const AppScreen() : const OnboardingScreen(),
        backgroundColor: AppStyle.primaryColor,
        duration: 2500,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
