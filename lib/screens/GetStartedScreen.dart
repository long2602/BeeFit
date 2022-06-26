// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:math';

import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/OnProgressScreen.dart';
import 'package:beefit/screens/WelcomeScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  bool _maleIsTapped = false,
      _femaleIsTapped = false,
      _chooseArm = false,
      _chooseChest = false,
      _chooseAbs = false,
      _chooseLeg = false,
      _chooseButt = false,
      _chooseFull = false;

  int _goalListIndex = 0,
      _physiqueIndex = 2,
      _desiredPhyIndex = 1,
      _currentHeight = 150,
      _currentWeight = 50,
      _idealWeight = 50,
      _planListIndex = 0;

  late TabController _tabController;

  final List _manGoals = [
    {"title": "Lose Weight", "img": "test4.png"},
    {"title": "Build Muscle", "img": "test5.png"},
    {"title": "Keep Fit", "img": "test6.png"},
  ];

  final List _womenGoals = [
    {"title": "Lose Weight", "img": "test.png"},
    {"title": "Build Muscle", "img": "test2.png"},
    {"title": "Get Toned", "img": "test3.png"},
  ];

  final List _physiques = [
    {
      "title": "Thin",
      "img": "thin.jpg",
      "des": "You have a low amount of body fat and a low muscle mass level.",
      "icon": "😐"
    },
    {
      "title": "Thin & Muscular",
      "img": "thin-muscular.jpg",
      "des":
          "You have a low amount of body fat and a standard level off muscle mass.",
      "icon": "😄"
    },
    {
      "title": "Standard",
      "img": "standard.jpg",
      "des": "You have average levels of both body fat and muscle mass.",
      "icon": "😃"
    },
    {
      "title": "Standard Muscular",
      "img": "standard-muscular.jpg",
      "des":
          "You have an average amount of fat percentage and a high muscle mass level.",
      "icon": "😄"
    },
    {
      "title": "Obese",
      "img": "obese.jpg",
      "des":
          "You have a high fat percentage and a standard level of muscle mass.",
      "icon": "😐"
    },
  ];

  final List _desiredPhysiques = [
    {
      "title": "Thin & Muscular",
      "img": "thin-muscular.jpg",
      "des":
          "This is a healthy Physique rating. Watch out people can be very jealous!",
      "icon": "😉"
    },
    {
      "title": "Standard Muscular",
      "img": "standard.jpg",
      "des":
          "You can be proud of this physique rating. This is a rating which some athletes have.",
      "icon": "😄"
    },
    {
      "title": "Very Muscular",
      "img": "standard-muscular.jpg",
      "des":
          "You have an average amount of fat percentage and a high muscle mass level.",
      "icon": "😃"
    }
  ];

  final List _plans = [
    {"frequency": "2 times/week", "des": "I don't have much time."},
    {"frequency": "3 times/week", "des": "I have free time, but not much."},
    {"frequency": "4 times/week", "des": "I can work out often."},
    {"frequency": "6 times/week", "des": "I can do the workout all day."}
  ];

  late RulerPickerController _hRulerController,
      _wRulerController,
      _iwRulerController;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 11, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    _hRulerController = RulerPickerController(value: 0);
    _wRulerController = RulerPickerController(value: 0);
    _iwRulerController = RulerPickerController(value: 0);

    _ageController.addListener(() {
      setState(() {});
    });
    _nameController.addListener(() {
      setState(() {});
    });
  }

  double _BMICalculate({required double weight, required double height}) {
    return weight / pow((height * 0.01), 2);
  }

  double _BMRCalculate({required double weight, required double height}) {
    double activeFactor = 1.2;
    switch (_planListIndex) {
      case 1:
        activeFactor = 1.375;
        break;
      case 2:
        activeFactor = 1.55;
        break;
      case 3:
        activeFactor = 1.725;
        break;
      case 4:
        activeFactor = 1.9;
        break;
    }
    if (_femaleIsTapped) {
      return (655 +
              (9.6 * weight) +
              (1.8 * height) -
              (4.7 * int.parse(_ageController.text))) *
          activeFactor;
    }
    return (66 +
            (13.7 * weight) +
            (5 * height) -
            (6.8 * int.parse(_ageController.text))) *
        activeFactor;
  }

  @override
  Widget build(BuildContext context) {
    List _choosedList = [];

    if (_maleIsTapped == true) {
      _choosedList = _manGoals;
    } else {
      _choosedList = _womenGoals;
    }

    var _changedWeight = (_idealWeight - _currentWeight).abs();
    var _bmi = _BMICalculate(
        height: _currentHeight.toDouble(), weight: _currentWeight.toDouble());
    var _newBMI = _BMICalculate(
        weight: _idealWeight.toDouble(), height: _currentHeight.toDouble());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
        child: _tabController.index == 0
            ? CommonButton(
                backgroundColor:
                    _maleIsTapped == true || _femaleIsTapped == true
                        ? Color(AppMethods.hexColor("#fb9b28"))
                        : Colors.grey.shade400,
                textColor: AppStyle.whiteColor,
                text: 'Next',
                onPressed: () {
                  if (_maleIsTapped == true || _femaleIsTapped == true) {
                    _tabController.index = 1;
                  } else {
                    Get.snackbar(
                      "Please choose your gender!",
                      "You did not choose your gender. Please choose one to continue.",
                      dismissDirection: DismissDirection.horizontal,
                      colorText: Colors.white,
                      snackStyle: SnackStyle.FLOATING,
                      barBlur: 30,
                      backgroundColor: Colors.black54,
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                    );
                  }
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButton(
                    width: 170,
                    backgroundColor: Colors.white,
                    textColor: Color(AppMethods.hexColor("#fb9b28")),
                    text: 'Previous',
                    borderSide: BorderSide(
                        color: Color(AppMethods.hexColor("#fb9b28")), width: 2),
                    onPressed: () {
                      switch (_tabController.index) {
                        case 1:
                          {
                            _tabController.index--;
                          }
                          break;
                        case 3:
                          {
                            if (_goalListIndex == 0) {
                              _tabController.index -= 2;
                            } else {
                              _tabController.index--;
                            }
                          }
                          break;
                        default:
                          {
                            _tabController.index--;
                          }
                      }
                    },
                  ),
                  CommonButton(
                    width: 170,
                    backgroundColor: Color(AppMethods.hexColor("#fb9b28")),
                    textColor: AppStyle.whiteColor,
                    text: 'Next',
                    onPressed: () {
                      switch (_tabController.index) {
                        case 1:
                          {
                            if (_goalListIndex == 0) {
                              _tabController.index += 2;
                            } else {
                              _tabController.index++;
                            }
                          }
                          break;
                        case 5:
                          {
                            if (_formKey1.currentState!.validate()) {
                              _tabController.index++;
                            }
                          }
                          break;
                        case 10:
                          {
                            {
                              if (_formKey2.currentState!.validate()) {
                                // Navigator.pushReplacement(
                                //     context,
                                //     AppMethods.animatedRoute(
                                //         const OnProgressScreen()));
                                Navigator.pushReplacement(
                                    context,
                                    AppMethods.animatedRoute(WelcomeScreen(
                                        name: _nameController.text)));
                              }
                            }
                          }
                          break;
                        default:
                          {
                            _tabController.index++;
                          }
                      }
                    },
                  ),
                ],
              ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          //Gender 0
          TabChild(
              title1: "What's your ",
              keyword: "gender",
              title2: "?",
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GenderCard(
                    mainTapped: _maleIsTapped,
                    secondaryCheck: _femaleIsTapped,
                    gender: "Male",
                    imgName: "male.png",
                    action: () {
                      setState(() {
                        _maleIsTapped = true;
                        _femaleIsTapped = false;
                      });
                    },
                  ),
                  GenderCard(
                    mainTapped: _femaleIsTapped,
                    secondaryCheck: _maleIsTapped,
                    gender: "Female",
                    imgName: "female.png",
                    action: () {
                      setState(() {
                        _femaleIsTapped = true;
                        _maleIsTapped = false;
                      });
                    },
                  ),
                ],
              )),
          //Goals 1
          TabChild(
            title1: "What is your ",
            title2: "?",
            keyword: "goal",
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _choosedList[_goalListIndex]["title"],
                  style: TextStyle(
                      color: Color(AppMethods.hexColor("383B53")),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                CarouselSlider.builder(
                  itemCount: _choosedList.length,
                  itemBuilder: (context, index, realIndex) {
                    return OptionCard(
                      imgName: _choosedList[index]["img"],
                      fill: Colors.white,
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: false,
                      height: 320 * AppMethods.screenScale(context),
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      initialPage: _goalListIndex,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _goalListIndex = index;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            _choosedList.length,
                            (index) => Indicator(
                                isActive:
                                    _goalListIndex == index ? true : false),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //Focus area 2
          _maleIsTapped == true
              ? TabChild(
                  title1: "What is your ",
                  keyword: "focus area",
                  title2: "?",
                  widget: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/imgs/body-man.png",
                          height: 450,
                        ),
                      ),
                      Positioned(
                          top: 205,
                          left: 120,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/arm-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 220,
                          left: 120,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/chest-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 265,
                          left: 120,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/abs-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 385,
                          left: 120,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/leg-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BodyAreaSelection(
                            text: "Arm",
                            isTapped: _chooseArm,
                            action: () {
                              setState(() {
                                _chooseArm = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Chest",
                            isTapped: _chooseChest,
                            action: () {
                              setState(() {
                                _chooseChest = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Abs",
                            isTapped: _chooseAbs,
                            action: () {
                              setState(() {
                                _chooseAbs = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Leg",
                            isTapped: _chooseLeg,
                            action: () {
                              setState(() {
                                _chooseLeg = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Full body",
                            isTapped: _chooseFull,
                            action: () {
                              setState(() {
                                _chooseFull = true;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseButt = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ))
              : TabChild(
                  title1: "What is your ",
                  keyword: "focus area",
                  title2: "?",
                  widget: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/imgs/body-women.png",
                          height: 450,
                        ),
                      ),
                      Positioned(
                          top: 205,
                          left: 103,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/arm-line2.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 265,
                          left: 100,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/abs-line2.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 325,
                          left: 87,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/leg-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Positioned(
                          top: 385,
                          left: 100,
                          child: SvgPicture.asset(
                            'assets/imgs/svg/leg-line.svg',
                            // color: Color(AppMethods.hexColor("#fb9b28")),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BodyAreaSelection(
                            text: "Arm",
                            isTapped: _chooseArm,
                            action: () {
                              setState(() {
                                _chooseArm = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Abs",
                            isTapped: _chooseAbs,
                            action: () {
                              setState(() {
                                _chooseAbs = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Butt",
                            isTapped: _chooseButt,
                            action: () {
                              setState(() {
                                _chooseButt = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Leg",
                            isTapped: _chooseLeg,
                            action: () {
                              setState(() {
                                _chooseLeg = true;
                                _chooseFull = false;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BodyAreaSelection(
                            text: "Full body",
                            isTapped: _chooseFull,
                            action: () {
                              setState(() {
                                _chooseFull = true;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseButt = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
          //Current physique 3
          TabChild(
            title1: "What is your current ",
            keyword: "physique",
            title2: "?",
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _physiques[_physiqueIndex]["title"],
                  style: TextStyle(
                      color: Color(AppMethods.hexColor("383B53")),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                CarouselSlider.builder(
                  itemCount: _physiques.length,
                  itemBuilder: (context, index, realIndex) {
                    return OptionCard(
                      imgName: _physiques[index]["img"],
                      fill: Color(AppMethods.hexColor("233b55")),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: false,
                      height: 320 * AppMethods.screenScale(context),
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      initialPage: _physiqueIndex,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _physiqueIndex = index;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            _physiques.length,
                            (index) => Indicator(
                                isActive:
                                    _physiqueIndex == index ? true : false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 5, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Skinny",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Heavy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(_physiques[_physiqueIndex]["icon"],
                          style: const TextStyle(fontSize: 25)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _physiques[_physiqueIndex]["des"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Color(AppMethods.hexColor("FFFBF5")),
                  ),
                ),
              ],
            ),
          ),
          //Desired physique 4
          TabChild(
            title1: "What is your ",
            keyword: "ideal physique",
            title2: "?",
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _desiredPhysiques[_desiredPhyIndex]["title"],
                  style: TextStyle(
                      color: Color(AppMethods.hexColor("383B53")),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                CarouselSlider.builder(
                  itemCount: _desiredPhysiques.length,
                  itemBuilder: (context, index, realIndex) {
                    return OptionCard(
                      imgName: _desiredPhysiques[index]["img"],
                      fill: Color(AppMethods.hexColor("233b55")),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: false,
                      height: 320 * AppMethods.screenScale(context),
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      initialPage: _desiredPhyIndex,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _desiredPhyIndex = index;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            _desiredPhysiques.length,
                            (index) => Indicator(
                                isActive:
                                    _desiredPhyIndex == index ? true : false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 27, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Lean",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Bulky",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(_desiredPhysiques[_desiredPhyIndex]["icon"],
                          style: const TextStyle(fontSize: 25)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _desiredPhysiques[_desiredPhyIndex]["des"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Color(AppMethods.hexColor("FFFBF5")),
                  ),
                ),
              ],
            ),
          ),
          //Year old 5
          TabChild(
            title1: "How ",
            keyword: "old ",
            title2: "are you?",
            widget: Form(
              key: _formKey1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: TextFormField(
                      cursorColor: Color(AppMethods.hexColor("#fb9b28")),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: true,
                      validator: (val) {
                        if (val == "") return "Please enter your age.";
                        return null;
                      },
                      controller: _ageController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Color(AppMethods.hexColor("#383B53")),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Current height 6
          TabChild(
            title1: "What is your ",
            keyword: "height",
            title2: "?",
            widget: Center(
              child: Transform.rotate(
                angle: -pi / 2,
                child: RulerPicker(
                  controller: _hRulerController,
                  beginValue: 100,
                  endValue: 250,
                  initValue: _currentHeight + 3,
                  scaleLineStyleList: const [
                    ScaleLineStyle(
                        color: Colors.black, width: 1.5, height: 30, scale: 0),
                  ],
                  onValueChange: (value) {
                    setState(() {
                      _currentHeight = value - 3;
                    });
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  rulerMarginTop: 200,
                  rulerScaleTextStyle: const TextStyle(color: Colors.black),
                  marker: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        origin: const Offset(-5, 25),
                        angle: pi / 2,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color:
                                        Color(AppMethods.hexColor("#fb9b28")),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        30 * AppMethods.fontScale(context)),
                                children: [
                                  TextSpan(text: _currentHeight.toString()),
                                  const TextSpan(
                                      text: " cm",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18))
                                ])),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -30),
                        child: Container(
                            width: 5,
                            height: 230,
                            decoration: BoxDecoration(
                                color: Color(AppMethods.hexColor("fb9b28"))
                                    .withAlpha(200),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Current weight 7
          TabChild(
            title1: "What is your ",
            keyword: "weight",
            title2: "?",
            widget: Column(
              children: [
                const SizedBox(height: 50),
                RulerPicker(
                  controller: _wRulerController,
                  beginValue: 30,
                  endValue: 200,
                  initValue: _currentWeight + 3,
                  scaleLineStyleList: const [
                    ScaleLineStyle(
                        color: Colors.black, width: 1.5, height: 30, scale: 0),
                  ],
                  onValueChange: (value) {
                    setState(() {
                      _currentWeight = value - 3;
                    });
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  rulerMarginTop: 100,
                  rulerScaleTextStyle: const TextStyle(color: Colors.black),
                  marker: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(AppMethods.hexColor("#fb9b28")),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30 * AppMethods.fontScale(context)),
                              children: [
                                TextSpan(text: _currentWeight.toString()),
                                const TextSpan(
                                    text: " kg",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18))
                              ])),
                      Container(
                          width: 5,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Color(AppMethods.hexColor("fb9b28"))
                                  .withAlpha(200),
                              borderRadius: BorderRadius.circular(5))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Current BMI",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _bmi.toStringAsFixed(1),
                            style: TextStyle(
                                color: Color(AppMethods.hexColor("fb9b28")),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _bmi < 18.5
                              ? "You have a great potential to get in a better shape, move now!"
                              : _bmi >= 18.5 && _bmi <= 25
                                  ? "You've got a great figure! Keep it up to be more perfect!"
                                  : _bmi > 25 && _bmi < 27
                                      ? "You only need a bit more sweaty exercises to see a fitter you!"
                                      : "You may need to do more workouts to be better and healthier!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Color(AppMethods.hexColor("FFFBF5")),
                  ),
                ),
              ],
            ),
          ),
          //Ideal weight 8
          TabChild(
            title1: "What is your ",
            keyword: "ideal weight",
            title2: "?",
            widget: Column(
              children: [
                const SizedBox(height: 50),
                Stack(
                  children: [
                    _idealWeight > _currentWeight
                        ? Positioned(
                            top: 100,
                            right: MediaQuery.of(context).size.width / 2 - 30,
                            child: Container(
                              height: 40,
                              width: _changedWeight.toDouble() * 10,
                              color: Color(AppMethods.hexColor("F6CF8D")),
                            ),
                          )
                        : Positioned(
                            top: 100,
                            left: MediaQuery.of(context).size.width / 2 - 30,
                            child: Container(
                              height: 40,
                              width: _changedWeight.toDouble() * 10,
                              color: Color(AppMethods.hexColor("F6CF8D")),
                            ),
                          ),
                    RulerPicker(
                      controller: _iwRulerController,
                      beginValue: 30,
                      endValue: 200,
                      initValue: _idealWeight + 3,
                      rulerBackgroundColor: Colors.white.withAlpha(150),
                      scaleLineStyleList: const [
                        ScaleLineStyle(
                            color: Colors.black,
                            width: 1.5,
                            height: 30,
                            scale: 0),
                      ],
                      onValueChange: (value) {
                        setState(() {
                          _idealWeight = value - 3;
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      rulerMarginTop: 100,
                      rulerScaleTextStyle: const TextStyle(color: Colors.black),
                      marker: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentWeight.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                "assets/imgs/svg/to-icon.svg",
                                height: 10,
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color(
                                              AppMethods.hexColor("#fb9b28")),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30 *
                                              AppMethods.fontScale(context)),
                                      children: [
                                        TextSpan(text: _idealWeight.toString()),
                                        const TextSpan(
                                            text: " kg",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18))
                                      ])),
                              const SizedBox(width: 55),
                            ],
                          ),
                          Container(
                              width: 5,
                              height: 65,
                              decoration: BoxDecoration(
                                  color: Color(AppMethods.hexColor("fb9b28"))
                                      .withAlpha(200),
                                  borderRadius: BorderRadius.circular(5))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/imgs/drop.png",
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _newBMI < 18.5
                                ? "Attention!"
                                : _newBMI >= 18.5 && _newBMI <= 25
                                    ? "Reasonable target!"
                                    : _newBMI > 25 && _newBMI < 27
                                        ? "Reasonable target!"
                                        : "Attention!",
                            style: TextStyle(
                                color: Color(AppMethods.hexColor("fb9b28")),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "You will ${_idealWeight > _currentWeight ? "gain" : "lose"} ${(100 - _idealWeight * 100 / _currentWeight).abs().toStringAsFixed(0)}% of body weight",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _newBMI >= 18.5 &&
                                _newBMI <= 25 &&
                                _idealWeight < _currentWeight
                            ? "Moderate weight loss can also make a big difference:\n- Lower blood pressure\n- Reduce the risk of type 2 diabetes"
                            : _newBMI >= 18.5 &&
                                    _newBMI <= 25 &&
                                    _idealWeight > _currentWeight
                                ? "Moderate weight gain can also make a big difference:\n- Better focus on daily tasks\n- Better mood and better sleep"
                                : _newBMI < 18.5
                                    ? "It seems that your target BMI is too low, which might cause some health problems..."
                                    : "It seems that your target BMI is too high, which might cause some health problems...",
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Color(AppMethods.hexColor("FFFBF5")),
                  ),
                ),
              ],
            ),
          ),
          //Workout routine 9
          TabChild(
            title1: "How ",
            keyword: "often ",
            title2: "would you like to work out?",
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: _plans.length,
                  itemBuilder: (context, index, realIndex) {
                    return OptionCard(
                      frequency: _plans[index]["frequency"],
                      des: _plans[index]["des"],
                      fill: Colors.white,
                      isPlan: true,
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: false,
                      height: 320 * AppMethods.screenScale(context),
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      initialPage: _planListIndex,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _planListIndex = index;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 40, right: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppStyle.gray4Color,
                          borderRadius: AppStyle.appBorder,
                        ),
                        height: 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            _plans.length,
                            (index) => Indicator(
                                isActive:
                                    _planListIndex == index ? true : false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Less",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "More",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Name 10
          TabChild(
            title1: "What is your ",
            keyword: "name",
            title2: "?",
            widget: Form(
              key: _formKey2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: TextFormField(
                      cursorColor: Color(AppMethods.hexColor("#fb9b28")),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: true,
                      validator: (val) {
                        if (val == "") return "Please enter your name.";
                        return null;
                      },
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Color(AppMethods.hexColor("#383B53")),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Body area selection
class BodyAreaSelection extends StatelessWidget {
  const BodyAreaSelection({
    Key? key,
    required this.text,
    required this.action,
    required this.isTapped,
  }) : super(key: key);

  final String text;
  final VoidCallback action;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 2,
                color: isTapped == false
                    ? Colors.grey.shade300
                    : Color(AppMethods.hexColor("#fb9b28"))),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: isTapped == false
                  ? Colors.black
                  : Color(AppMethods.hexColor("#fb9b28"))),
        ),
      ),
    );
  }
}

//Option card
class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    this.imgName,
    this.isPlan,
    required this.fill,
    this.frequency,
    this.des,
  }) : super(key: key);

  final String? imgName, frequency, des;
  final bool? isPlan;
  final Color fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: 220,
      decoration: BoxDecoration(
          color: fill,
          border: isPlan == true
              ? Border.all(
                  width: 5, color: Color(AppMethods.hexColor("fb9b28")))
              : null,
          borderRadius: BorderRadius.circular(15)),
      child: isPlan == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  frequency!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(AppMethods.hexColor("fb9b28"))),
                ),
                const SizedBox(height: 25),
                Text(
                  des!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/imgs/$imgName', fit: BoxFit.contain)),
    );
  }
}

//Widget inside tabview
class TabChild extends StatelessWidget {
  const TabChild({
    Key? key,
    required this.widget,
    required this.title1,
    required this.title2,
    required this.keyword,
  }) : super(key: key);

  final Widget widget;
  final String title1, title2, keyword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30 * AppMethods.screenScale(context)),
      child: Column(
        children: [
          SizedBox(height: 40 * AppMethods.screenScale(context)),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color(AppMethods.hexColor("#383B53")),
                      fontWeight: FontWeight.bold,
                      fontSize: 25 * AppMethods.fontScale(context)),
                  children: [
                    TextSpan(text: title1),
                    TextSpan(
                        text: keyword,
                        style: TextStyle(
                            color: Color(AppMethods.hexColor("#fb9b28")),
                            fontWeight: FontWeight.bold)),
                    TextSpan(text: title2)
                  ])),
          Expanded(child: widget),
        ],
      ),
    );
  }
}

//Gender card
class GenderCard extends StatelessWidget {
  final bool mainTapped, secondaryCheck;
  final String gender, imgName;
  final VoidCallback action;

  const GenderCard({
    Key? key,
    required this.mainTapped,
    required this.secondaryCheck,
    required this.gender,
    required this.imgName,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/imgs/$imgName",
            height: mainTapped == true
                ? 320
                : mainTapped == false && secondaryCheck == false
                    ? 300
                    : 280,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 15),
          Text(
            gender,
            style: TextStyle(
                color: mainTapped == true
                    ? Color(AppMethods.hexColor("fb9b28"))
                    : secondaryCheck == true
                        ? Colors.grey
                        : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

//Indicator below option cards
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
        color: _isActive
            ? Color(AppMethods.hexColor("fb9b28"))
            : AppStyle.gray4Color,
        borderRadius: AppStyle.appBorder,
        border:
            _isActive ? Border.all(color: AppStyle.whiteColor, width: 2) : null,
        boxShadow: _isActive
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            : null,
      ),
      width: _isActive ? 18 : 15,
      height: _isActive ? 18 : 15,
    );
  }
}
