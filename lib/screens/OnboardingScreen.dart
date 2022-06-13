// ignore_for_file: file_names

import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/screens/GetStartedScreen.dart';
import 'package:beefit/screens/getstartedscreen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scale = AppMethods.fontScale(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(children: [
          IntroductionScreen(
            globalBackgroundColor: Colors.transparent,
            pages: [
              _slidingPages(
                  title: "Keep fit",
                  desc:
                      "We will help you get in shape based on your desired body type, sounds interesting right?",
                  imgFile: "onboarding1.jpg"),
              _slidingPages(
                  title: "Workouts",
                  desc:
                      "With a rich number of exercises, you will not feel bored while practicing with us",
                  imgFile: "onboarding2.jpg"),
              _slidingPages(
                  title: "Nutrition",
                  desc:
                      "In addition, we can suggest the necessary nutrients for you to workout effectively",
                  imgFile: "onboarding3.png"),
              _slidingPages(
                  title: "Convenient",
                  desc:
                      "You can practice anywhere you want, at home or outdoors, depending on your choice",
                  imgFile: "onboarding5.png"),
              _slidingPages(
                  title: "Track your progress",
                  desc:
                      "You can track your daily workout and nutrition to see how your progress is improving",
                  imgFile: "onboarding4.png"),
            ],
            dotsDecorator: DotsDecorator(
                activeColor: Color(AppMethods.hexColor("fb9b28")),
                color: Colors.grey.shade400,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10 * _scale)),
                size: Size(8 * _scale, 8 * _scale),
                activeSize: Size(30 * _scale, 8 * _scale),
                spacing: EdgeInsets.all(5 * _scale)),
            showDoneButton: false,
            showSkipButton: false,
            showNextButton: false,
            isTopSafeArea: true,
            isBottomSafeArea: true,
            controlsMargin: EdgeInsets.only(bottom: 150 * _scale),
          ),
          Positioned(
            height: 50 * _scale,
            bottom: 50 * _scale,
            left: 30 * _scale,
            right: 30 * _scale,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                  context, AppMethods.animatedRoute(const GetStartedScreen2())),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17 * AppMethods.fontScale(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15 * _scale)),
                primary: Color(AppMethods.hexColor("#fb9b28")),
              ),
            ),
          )
        ]),
      ),
    );
  }

  //The sliding pages
  PageViewModel _slidingPages(
      {required String title, required String desc, required String imgFile}) {
    final _scale = AppMethods.screenScale(context);
    return PageViewModel(
      title: title,
      image: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0,
              blurRadius: 30,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/imgs/$imgFile",
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: desc,
      decoration: PageDecoration(
        titlePadding: EdgeInsets.zero,
        imagePadding:
            EdgeInsets.fromLTRB(30 * _scale, 0, 30 * _scale, 30 * _scale),
        bodyPadding: EdgeInsets.all(30 * _scale),
        bodyTextStyle: TextStyle(
          fontSize: 18 * AppMethods.fontScale(context),
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          fontSize: 30 * AppMethods.fontScale(context),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
