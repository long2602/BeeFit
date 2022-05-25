import 'package:beefit/constants/app_style.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:beefit/widgets/OnPageView.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnPageView(
            title: "What’s your Gender?",
            pageController: pageController,
            widget: Container(
              width: double.infinity,
              height: 100,
              color: AppStyle.gray1Color,
              child: PageView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                        color: AppStyle.primaryColor,
                      ),
                    );
                  }),
            ),
          ),
          OnPageView(
            title: "What’s your main goal?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your focus area?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your current body shape?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your desired body shape?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your name?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "How old are you?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your height?",
            pageController: pageController,
            widget: Container(),
          ),
          OnPageView(
            title: "What’s your current weight?",
            pageController: pageController,
            widget: Container(),
          ),
        ],
      ),
    );
  }
}
