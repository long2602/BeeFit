import 'package:beefit/constants/app_style.dart';
import 'package:beefit/constants/app_ui.dart';
import 'package:beefit/screens/get_started_screen.dart';
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
    final _scale = AppUI.fontScale(context);
    return Scaffold(
      body: Stack(children: [
        IntroductionScreen(
          globalBackgroundColor: AppStyle.primaryColor,
          pages: [
            _slidingPages(
                title: "Keep fit",
                desc:
                    "We will help you get in shape based on your desired body type, sounds interesting right?",
                imgFile: "buildMuscle.png",
                height: 280,
                paddingBottom: 30),
            _slidingPages(
                title: "Workouts",
                desc:
                    "With a rich number of exercises, you will not feel bored while practicing with us",
                imgFile: "buildMuscle.png",
                height: 280,
                paddingBottom: 30),
            _slidingPages(
                title: "Nutrition",
                desc:
                    "In addition, we can suggest the necessary nutrients for you to workout effectively",
                imgFile: "buildMuscle.png",
                height: 300,
                paddingBottom: 15),
            _slidingPages(
                title: "Track your progress",
                desc:
                    "You can track your daily workout and nutrition to see how your progress is improving",
                imgFile: "buildMuscle.png",
                height: 280,
                paddingBottom: 25),
            _slidingPages(
                title: "Convenient",
                desc:
                    "You can practice anywhere you want, at home or outdoors, depending on your choice",
                imgFile: "buildMuscle.png",
                height: 280,
                paddingBottom: 15),
          ],
          dotsDecorator: DotsDecorator(
              activeColor: Colors.white,
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
          controlsMargin: EdgeInsets.only(bottom: 130 * _scale),
        ),
        Positioned(
          height: 47.5 * _scale,
          bottom: 47.5 * _scale,
          left: 30 * _scale,
          right: 30 * _scale,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context, AppUI.animatedRoute(const GetStartedScreen())),
            child: Text(
              "Get Started",
              style: TextStyle(
                color: AppStyle.primaryColor,
                fontSize: 17 * AppUI.fontScale(context),
                fontWeight: FontWeight.w900,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25 * _scale)),
              primary: Colors.white,
            ),
          ),
        )
      ]),
    );
  }

  //The sliding pages
  PageViewModel _slidingPages(
      {required String title,
      required String desc,
      required String imgFile,
      required double height,
      required double paddingBottom}) {
    final _scale = AppUI.screenScale(context);
    return PageViewModel(
      title: title,
      image: ClipRRect(
        borderRadius: BorderRadius.circular(30 * _scale),
        child: Image.asset(
          "assets/imgs/${imgFile}",
          height: height,
          fit: BoxFit.cover,
        ),
      ),
      body: desc,
      decoration: PageDecoration(
        imagePadding: EdgeInsets.fromLTRB(
            30 * _scale, 0, 30 * _scale, paddingBottom * _scale),
        bodyPadding: EdgeInsets.all(30 * _scale),
        bodyTextStyle: TextStyle(
          fontSize: 18 * AppUI.fontScale(context),
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          fontSize: 30 * AppUI.fontScale(context),
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
