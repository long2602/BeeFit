
import 'package:beefit/constants/app_style.dart';
import 'package:beefit/constants/app_ui.dart';
import 'package:beefit/widgets/OnPageView.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  final currentController = PageController();
  var  _selectedIndex = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    currentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _scale = AppUI.screenScale(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
      ),
      body: PageView(
        controller: pageController,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          OnPageView(
            title: "What’s your Gender?",
            pageController: pageController,
            widget: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 283 * _scale,
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.7),
                      itemCount: 5,
                      onPageChanged: (index){
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        var _dot = _selectedIndex == index ? 1 :0.8;
                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 350),
                          tween: Tween(begin: _dot, end: _dot),
                          curve: Curves.ease,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value is double ? value : 1,
                              child: child,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            margin:
                                EdgeInsets.symmetric(horizontal: 20 * _scale),
                            width: 200 * _scale,
                            height: 283 * _scale,
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.appBorder,
                              color: _selectedIndex == index ? AppStyle.primaryColor: AppStyle.gray5Color,
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration:  BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(5, (index) => Indicator(isActive: _selectedIndex == index ?true :false)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
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

class Indicator extends StatelessWidget {
  final bool _isActive;

  const Indicator({Key? key, required bool isActive})
      : _isActive = isActive,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: _isActive ? AppStyle.primaryColor: AppStyle.gray4Color,
          borderRadius: AppStyle.appBorder,
        ),
        width: _isActive ? 15 : 15,
        height: _isActive ? 15 : 15,

    );
  }
}
