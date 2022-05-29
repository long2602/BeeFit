import 'package:beefit/constants/app_style.dart';
import 'package:beefit/constants/app_ui.dart';
import 'package:beefit/widgets/OnPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  final currentController = PageController();
  var _selectedIndex = 0;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  RulerPickerController? _rulerPickerController;
  int currentValue = 50;

  @override
  void initState() {
    _rulerPickerController = RulerPickerController(value: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _scaleScreen = AppUI.screenScale(context);
    final double _scaleFont = AppUI.fontScale(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
      ),
      body: PageView(
        controller: pageController,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          /**
           * Gender
           */
          OnPageView(
            title: "What’s your Gender?",
            pageController: pageController,
            widget: Container(),
          ),

          /**
           * Main goal
           */
          OnPageView(
            title: "What’s your main goal?",
            pageController: pageController,
            widget: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 46 * _scaleScreen,
                      vertical: 10 * _scaleScreen),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: AppStyle.appBorder,
                    child: InkWell(
                      borderRadius: AppStyle.appBorder,
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.appBorder,
                            border: Border.all(
                                color: AppStyle.gray5Color, width: 1)),
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lose Weight',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26 * _scaleFont,
                                ),
                              ),
                              Image.asset(
                                'assets/imgs/scale.png',
                                height: 70 * _scaleScreen,
                                width: 70 * _scaleScreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 46 * _scaleScreen,
                      vertical: 10 * _scaleScreen),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: AppStyle.appBorder,
                    child: InkWell(
                      borderRadius: AppStyle.appBorder,
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.appBorder,
                            border: Border.all(
                                color: AppStyle.gray5Color, width: 1)),
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Build Muscle',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26 * _scaleFont,
                                ),
                              ),
                              Image.asset(
                                'assets/imgs/buildMuscle.png',
                                height: 70 * _scaleScreen,
                                width: 70 * _scaleScreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 46 * _scaleScreen,
                    vertical: 10 * _scaleScreen,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: AppStyle.appBorder,
                    child: InkWell(
                      borderRadius: AppStyle.appBorder,
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.appBorder,
                            border: Border.all(
                                color: AppStyle.gray5Color, width: 1)),
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Keep Fit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26 * _scaleFont,
                                ),
                              ),
                              Image.asset(
                                'assets/imgs/keepFit.png',
                                height: 70 * _scaleScreen,
                                width: 70 * _scaleScreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /**
           * Focus area
           */
          OnPageView(
            title: "What’s your focus area?",
            pageController: pageController,
            widget: Container(),
          ),

          /**
           * Current body shape
           */
          OnPageView(
            title: "What’s your current body shape?",
            pageController: pageController,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 283 * _scaleScreen,
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.7),
                      itemCount: 5,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        var _dot = _selectedIndex == index ? 1 : 0.8;
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 20 * _scaleScreen),
                            width: 200 * _scaleScreen,
                            height: 283 * _scaleScreen,
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.appBorder,
                              color: _selectedIndex == index
                                  ? AppStyle.primaryColor
                                  : AppStyle.gray5Color,
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                              5,
                              (index) => Indicator(
                                  isActive:
                                      _selectedIndex == index ? true : false)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          /**
           * Desired body shape
           */
          OnPageView(
            title: "What’s your desired body shape?",
            pageController: pageController,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 283 * _scaleScreen,
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.7),
                      itemCount: 5,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        var _dot = _selectedIndex == index ? 1 : 0.8;
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 20 * _scaleScreen),
                            width: 200 * _scaleScreen,
                            height: 283 * _scaleScreen,
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.appBorder,
                              color: _selectedIndex == index
                                  ? AppStyle.primaryColor
                                  : AppStyle.gray5Color,
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                              5,
                              (index) => Indicator(
                                  isActive:
                                      _selectedIndex == index ? true : false)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          /**
           * Name
           */
          OnPageView(
            title: "What’s your name?",
            pageController: pageController,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60 * _scaleScreen),
              child: TextField(
                controller: nameController,
                style: TextStyle(
                    fontSize: 30 * _scaleFont,
                    color: AppStyle.secondaryColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /**
           * Age
           */
          OnPageView(
            title: "How old are you?",
            pageController: pageController,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60 * _scaleScreen),
              child: TextField(
                controller: ageController,
                style: TextStyle(
                    fontSize: 30 * _scaleFont,
                    color: AppStyle.secondaryColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /**
           * Height
           */
          OnPageView(
            title: "What’s your height?",
            pageController: pageController,
            widget: Container(),
          ),

          /**
           * Current Weight
           */
          OnPageView(
            title: "What’s your current weight?",
            pageController: pageController,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currentValue.toString(),
                            style: TextStyle(
                                color: AppStyle.primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30 * _scaleFont),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "kg",
                              style: TextStyle(
                                  color: AppStyle.black1Color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RulerPicker(
                        controller: _rulerPickerController!,
                        beginValue: 30,
                        endValue: 100,
                        initValue: currentValue,
                        rulerScaleTextStyle:
                            const TextStyle(color: AppStyle.black1Color),
                        scaleLineStyleList: const [
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1.5,
                              height: 30,
                              scale: 0),
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 25,
                              scale: 5),
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 15,
                              scale: -1)
                        ],
                        onValueChange: (value) {
                          setState(() {
                            currentValue = value;
                          });
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        rulerMarginTop: 30,
                        marker: Container(
                            width: 4,
                            height: 140,
                            decoration: BoxDecoration(
                                color: AppStyle.primaryColor,
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Current BMI',
                          style: TextStyle(
                            fontSize: 16 * _scaleFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '17.9',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppStyle.primaryColor,
                              fontSize: 30 * _scaleFont,
                            ),
                          ),
                          SizedBox(
                            width: 20 * _scaleScreen,
                          ),
                          Flexible(
                            child: Text(
                              'You have a great potential to get in a better shape, move now!',
                              style: TextStyle(
                                fontSize: 14 * _scaleFont,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /**
           * Target Weight
           */
          OnPageView(
            title: "What’s your target weight?",
            pageController: pageController,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currentValue.toString(),
                            style: TextStyle(
                                color: AppStyle.primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30 * _scaleFont),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "kg",
                              style: TextStyle(
                                  color: AppStyle.black1Color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RulerPicker(
                        controller: _rulerPickerController!,
                        beginValue: 30,
                        endValue: 100,
                        initValue: currentValue,
                        rulerScaleTextStyle:
                            const TextStyle(color: AppStyle.black1Color),
                        scaleLineStyleList: const [
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1.5,
                              height: 30,
                              scale: 0),
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 25,
                              scale: 5),
                          ScaleLineStyle(
                              color: Colors.grey,
                              width: 1,
                              height: 15,
                              scale: -1)
                        ],
                        onValueChange: (value) {
                          setState(() {
                            currentValue = value;
                          });
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        rulerMarginTop: 30,
                        marker: Container(
                            width: 4,
                            height: 140,
                            decoration: BoxDecoration(
                                color: AppStyle.primaryColor,
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Image.asset('assets/imgs/drop.png'),
                              const SizedBox(width: 2,),
                              Text(
                                'Sweet choice!',
                                style: TextStyle(
                                  fontSize: 16 * _scaleFont,
                                  fontWeight: FontWeight.bold,
                                  color: AppStyle.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'You will gain 5.4% of body weight',
                          style: TextStyle(
                            fontSize: 14 * _scaleFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
        color: _isActive ? AppStyle.primaryColor : AppStyle.gray4Color,
        borderRadius: AppStyle.appBorder,
      ),
      width: _isActive ? 15 : 15,
      height: _isActive ? 15 : 15,
    );
  }
}
