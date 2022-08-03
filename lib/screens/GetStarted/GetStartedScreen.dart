// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:math';
import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/GetStarted/OnProgressScreen.dart';
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
      _chooseFull = false,
      _chooseBeginner = false,
      _chooseIntermediate = false,
      _chooseAdvanced = false;

  int _goalListIndex = 0,
      _currentHeight = 150,
      _currentWeight = 50,
      _levelId = 1,
      _bdpId = 6;

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

  late RulerPickerController _hRulerController, _wRulerController;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    _hRulerController = RulerPickerController(value: 0);
    _wRulerController = RulerPickerController(value: 0);

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
    switch (_goalListIndex) {
      case 2:
        activeFactor = 1.55;
        break;
      case 1:
        activeFactor = 1.725;
        break;
      case 0:
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

    var _bmi = _BMICalculate(
        height: _currentHeight.toDouble(), weight: _currentWeight.toDouble());

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
                            if (_goalListIndex == 0 || _goalListIndex == 2) {
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
                            if (_goalListIndex == 0 || _goalListIndex == 2) {
                              _tabController.index += 2;
                            } else {
                              _tabController.index++;
                            }
                          }
                          break;
                        case 3:
                          {
                            if (_formKey1.currentState!.validate()) {
                              _tabController.index++;
                            }
                          }
                          break;
                        case 7:
                          {
                            {
                              if (_formKey2.currentState!.validate()) {
                                Navigator.pushReplacement(
                                    context,
                                    AppMethods.animatedRoute(OnProgressScreen(
                                      isMale: _maleIsTapped,
                                      height: _currentHeight,
                                      currentWeight: _currentWeight,
                                      name: _nameController.value.text,
                                      age: int.parse(_ageController.value.text),
                                      bmi: _bmi,
                                      bmr: _BMRCalculate(
                                          weight: _currentWeight.toDouble(),
                                          height: _currentHeight.toDouble()),
                                      goal: _goalListIndex,
                                      level: _levelId,
                                      muscleId: _bdpId,
                                    )));
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
                          if (_goalListIndex == 0 || _goalListIndex == 2) {
                            _bdpId = 6;
                          }
                          print(_bdpId);
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
                                _chooseArm
                                    ? _chooseArm = false
                                    : _chooseArm = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                                _bdpId = 1;
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
                                _chooseChest
                                    ? _chooseChest = false
                                    : _chooseChest = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseLeg = false;
                                _bdpId = 2;
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
                                _chooseAbs
                                    ? _chooseAbs = false
                                    : _chooseAbs = true;
                                _chooseFull = false;
                                _chooseArm = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                                _bdpId = 3;
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
                                _chooseLeg
                                    ? _chooseLeg = false
                                    : _chooseLeg = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseChest = false;
                                _chooseArm = false;
                                _bdpId = 5;
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
                                _chooseFull
                                    ? _chooseFull = false
                                    : _chooseFull = true;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                                _bdpId = 6;
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
                                _chooseArm
                                    ? _chooseArm = false
                                    : _chooseArm = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                                _bdpId = 1;
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
                                _chooseAbs
                                    ? _chooseAbs = false
                                    : _chooseAbs = true;
                                _chooseFull = false;
                                _chooseArm = false;
                                _chooseChest = false;
                                _chooseLeg = false;
                                _bdpId = 3;
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
                                _chooseButt
                                    ? _chooseButt = false
                                    : _chooseButt = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseLeg = false;
                                _bdpId = 4;
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
                                _chooseLeg
                                    ? _chooseLeg = false
                                    : _chooseLeg = true;
                                _chooseFull = false;
                                _chooseAbs = false;
                                _chooseButt = false;
                                _chooseArm = false;
                                _bdpId = 5;
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
                                _chooseFull
                                    ? _chooseFull = false
                                    : _chooseFull = true;
                                _chooseAbs = false;
                                _chooseArm = false;
                                _chooseButt = false;
                                _chooseLeg = false;
                                _bdpId = 6;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
          //Year old 3
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
                        if (int.parse(val!) < 6) {
                          return "Please enter age larger than 6.";
                        }
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
          //Current height 4
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
          //Current weight 5
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
          //Current level 6
          TabChild(
            title1: "What is your current ",
            keyword: "level",
            title2: "?",
            widget: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                LevelSelection(
                  title: "Beginner",
                  action: () {
                    setState(() {
                      _chooseBeginner = true;
                      _chooseIntermediate = false;
                      _chooseAdvanced = false;
                      _levelId = 1;
                    });
                  },
                  isTapped: _chooseBeginner,
                  des: "3 - 5 push-ups",
                  icon: '☝️😂',
                ),
                const SizedBox(
                  height: 20,
                ),
                LevelSelection(
                  title: "Intermediate",
                  action: () {
                    setState(() {
                      _chooseBeginner = false;
                      _chooseIntermediate = true;
                      _chooseAdvanced = false;
                      _levelId = 2;
                    });
                  },
                  isTapped: _chooseIntermediate,
                  des: '5 - 10 push-ups',
                  icon: '✌️😄',
                ),
                const SizedBox(
                  height: 20,
                ),
                LevelSelection(
                  title: "Advanced",
                  action: () {
                    setState(() {
                      _chooseBeginner = false;
                      _chooseIntermediate = false;
                      _chooseAdvanced = true;
                      _levelId = 3;
                    });
                  },
                  isTapped: _chooseAdvanced,
                  des: 'At least 10 push-ups',
                  icon: '👍😉',
                )
              ],
            ),
          ),

          //Name 7
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
                      onTap: () {
                        print(_bdpId);
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
class LevelSelection extends StatelessWidget {
  const LevelSelection({
    Key? key,
    required this.title,
    required this.action,
    required this.isTapped,
    required this.des,
    required this.icon,
  }) : super(key: key);

  final String title, des, icon;
  final VoidCallback action;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 2,
                color: isTapped == false
                    ? Colors.grey.shade300
                    : Color(AppMethods.hexColor("#fb9b28"))),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
                Text(
                  des,
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
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
