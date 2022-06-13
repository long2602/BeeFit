import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GetStartedScreen2 extends StatefulWidget {
  const GetStartedScreen2({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen2> createState() => _GetStartedScreen2State();
}

class _GetStartedScreen2State extends State<GetStartedScreen2>
    with SingleTickerProviderStateMixin {
  bool _maleIsTapped = false, _femaleIsTapped = false;
  int _goalListIndex = 0;
  late TabController _tabController;

  final List _manGoals = [
    {"title": "Lose Weight", "img": "test4.png"},
    {"title": "Build Muscle", "img": "test5.png"},
    {"title": "Keep Fit", "img": "test6.png"},
  ];

  final List _womenGoals = [
    {"title": "Lose Weight", "img": "test.png"},
    {"title": "Build Muscle", "img": "test2.png"},
    {"title": "Keep Fit", "img": "test3.png"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 11, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List _choosedList = [];
    if (_maleIsTapped == true) {
      _choosedList = _manGoals;
    } else {
      _choosedList = _womenGoals;
    }

    return GestureDetector(
      onTap: () => print(_tabController.index),
      child: Scaffold(
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
                          color: Color(AppMethods.hexColor("#fb9b28")),
                          width: 2),
                      onPressed: () {
                        // switch (_tabController.index) {
                        //   case 1:
                        //     {
                        //       _tabController.index--;
                        //     }
                        //     break;
                        //   case 3:
                        //     {
                        //       _tabController.index -= 2;
                        //     }
                        //     break;
                        //   default:
                        // }
                        _tabController.index--;
                      },
                    ),
                    CommonButton(
                      width: 170,
                      backgroundColor: Color(AppMethods.hexColor("#fb9b28")),
                      textColor: AppStyle.whiteColor,
                      text: 'Next',
                      onPressed: () {
                        // switch (_tabController.index) {
                        //   case 1:
                        //     {
                        //       _tabController.index += 2;
                        //     }
                        //     break;
                        //   case 2:
                        //     {
                        //       print("object");
                        //     }
                        //     break;
                        //   default:
                        // }
                        _tabController.index++;
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
            _tabChild(
              title1: "What's your ",
              keyword: "gender",
              title2: "?",
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _maleIsTapped = true;
                        _femaleIsTapped = false;
                      });
                    },
                    child: _genderCard(
                        mainTapped: _maleIsTapped,
                        secondaryCheck: _femaleIsTapped,
                        gender: "Male",
                        imgName: "male.png"),
                  ),
                  GestureDetector(
                      onTap: (() {
                        setState(() {
                          _femaleIsTapped = true;
                          _maleIsTapped = false;
                        });
                      }),
                      child: _genderCard(
                          mainTapped: _femaleIsTapped,
                          secondaryCheck: _maleIsTapped,
                          gender: "Female",
                          imgName: "female.png")),
                ],
              ),
            ),
            //Goals 1
            _tabChild(
              title1: "What is your ",
              keyword: "goal",
              title2: "?",
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
                      return _optionCard(imgName: _choosedList[index]["img"]);
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
            //Focus area
            _tabChild(
              title1: "What is your ",
              keyword: "focus area",
              title2: "?",
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Arm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Chest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Abs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Leg",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Full body",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/imgs/body-women.png",
                    height: 450,
                  ),
                ],
              ),
            ),
            //Current body fat 3
            _tabChild(
              title1: "What is your ",
              keyword: "body type ",
              title2: "?",
              widget: Container(
                child: Image.asset("assets/imgs/muscles.png"),
              ),
            ),
            //Desired body fat 4
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Year old 5
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Current height 6
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Current weight 7
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Ideal weight 8
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Workout routine 9
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
            //Name 10
            _tabChild(
              title1: "Which ",
              keyword: "song ",
              title2: "would you like to listen to?",
              widget: Container(),
            ),
          ],
        ),
      ),
    );
  }

  //Option card
  Widget _optionCard({required String imgName}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/imgs/$imgName', fit: BoxFit.cover),
      ),
    );
  }

  //Widget inside tabview
  Widget _tabChild(
      {required Widget widget,
      required String title1,
      required String title2,
      required String keyword}) {
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

  //Gender card
  Widget _genderCard(
      {required bool mainTapped,
      required bool secondaryCheck,
      required String gender,
      required String imgName}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(mainTapped == true ? 32 : 30),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 2,
                  color: mainTapped == true
                      ? Color(AppMethods.hexColor("fb9b28"))
                      : secondaryCheck == true
                          ? Colors.grey
                          : Colors.black54),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Image.asset(
            "assets/imgs/$imgName",
            height: mainTapped == true ? 105 : 100,
          ),
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
