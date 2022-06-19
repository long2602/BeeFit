// // ignore_for_file: file_names

// import 'dart:math';

// import 'package:beefit/constants/AppStyles.dart';
// import 'package:beefit/constants/AppMethods.dart';
// import 'package:beefit/screens/OnProgressScreen.dart';
// import 'package:beefit/widgets/CommonButton.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
// import 'package:get/get.dart';

// class GetStartedScreen extends StatefulWidget {
//   const GetStartedScreen({Key? key}) : super(key: key);

//   @override
//   State<GetStartedScreen> createState() => _GetStartedScreenState();
// }

// class _GetStartedScreenState extends State<GetStartedScreen> {
//   final _pageController = PageController();
//   final currentController = PageController();
//   var _selectedOften = 0;
//   // var _selectedDesiredBody = 0;
//   // var _selectedCurrentBody = 0;
//   final nameController = TextEditingController();
//   final ageController = TextEditingController();
//   RulerPickerController? _currentWeightController;
//   RulerPickerController? _targetWeightController;
//   RulerPickerController? _currentHeightController;

//   int _currentWeightValue = 50;
//   int _targetWeightValue = 50;
//   int _currentHeightValue = 150;

//   late bool _maleIsTapped, _femaleIsTapped;
//   late int _goalListIndex;

//   final List _goalList = [
//     {"title": "Lose Weight", "img": "loseweight.jpg"},
//     {"title": "Build Muscle", "img": "buildmuscles.jpg"},
//     {"title": "Keep Fit", "img": "keepfit.jpg"},
//   ];

//   @override
//   void initState() {
//     super.initState();

//     setState(() {
//       _maleIsTapped = false;
//       _femaleIsTapped = false;
//       _goalListIndex = 0;
//     });

//     _currentWeightController = RulerPickerController(value: 0);
//     _targetWeightController = RulerPickerController(value: 0);
//     _currentHeightController = RulerPickerController(value: 0);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     currentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double _scaleScreen = AppMethods.screenScale(context);
//     final double _scaleFont = AppMethods.fontScale(context);
//     return Scaffold(
//       body: PageView(

//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           //Gender selection
//           OnPageView(
//             title: "What’s your ",
//             keyword: "gender",
//             additionalText: "?",
//             pageController: _pageController,
//             childWidget: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _maleIsTapped = true;
//                       _femaleIsTapped = false;
//                     });
//                   },
//                   child: _genderCard(
//                       mainTapped: _maleIsTapped,
//                       secondaryCheck: _femaleIsTapped,
//                       gender: "Male",
//                       imgName: "male.png"),
//                 ),
//                 GestureDetector(
//                     onTap: (() {
//                       setState(() {
//                         _femaleIsTapped = true;
//                         _maleIsTapped = false;
//                       });
//                     }),
//                     child: _genderCard(
//                         mainTapped: _femaleIsTapped,
//                         secondaryCheck: _maleIsTapped,
//                         gender: "Female",
//                         imgName: "female.png")),
//               ],
//             ),
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true || _femaleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {
//                 if (_maleIsTapped == true || _femaleIsTapped == true) {
//                   _pageController.nextPage(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut);
//                 } else {
//                   Get.snackbar(
//                     "Please choose your gender!",
//                     "You did not choose your gender. Please choose one to continue.",
//                     dismissDirection: DismissDirection.horizontal,
//                     colorText: Colors.white,
//                     snackStyle: SnackStyle.FLOATING,
//                     barBlur: 30,
//                     backgroundColor: Colors.black54,
//                     isDismissible: true,
//                     duration: const Duration(seconds: 3),
//                   );
//                 }
//               },
//             ),
//           ),

//           //Goal selection
//           OnPageView(
//             title: "What’s your ",
//             keyword: "goal",
//             additionalText: "?",
//             pageController: _pageController,
//             childWidget: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   _goalList[_goalListIndex]["title"],
//                   style: TextStyle(
//                       color: Color(AppMethods.hexColor("383B53")),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 25),
//                 CarouselSlider.builder(
//                   itemCount: _goalList.length,
//                   itemBuilder: (context, index, realIndex) {
//                     return _optionCard(imgName: _goalList[index]["img"]);
//                   },
//                   options: CarouselOptions(
//                       autoPlay: false,
//                       height: 283 * AppMethods.screenScale(context),
//                       viewportFraction: 0.7,
//                       enableInfiniteScroll: false,
//                       initialPage: _goalListIndex ,
//                       enlargeCenterPage: true,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _goalListIndex = index;
//                         });
//                       }),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(top: 30.0, left: 40, right: 40),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppStyle.gray4Color,
//                           borderRadius: AppStyle.appBorder,
//                         ),
//                         height: 2.5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ...List.generate(
//                             _goalList.length,
//                             (index) => Indicator(
//                                 isActive:
//                                     _goalListIndex == index ? true : false),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             bottomWidget: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CommonButton(
//                   width: 170,
//                   backgroundColor: Colors.white,
//                   textColor: Color(AppMethods.hexColor("#fb9b28")),
//                   text: 'Previous',
//                   borderSide: BorderSide(
//                       color: Color(AppMethods.hexColor("#fb9b28")), width: 2),
//                   onPressed: () {
//                     _pageController.previousPage(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.easeInOut);
//                   },
//                 ),
//                 CommonButton(
//                   width: 170,
//                   backgroundColor: Color(AppMethods.hexColor("#fb9b28")),
//                   textColor: AppStyle.whiteColor,
//                   text: 'Next',
//                   onPressed: () {
//                     print(_goalList[_goalListIndex]["title"]);
//                     _pageController.nextPage(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.easeInOut);
//                   },
//                 ),
//               ],
//             ),
//           ),

//           //Muscle groups selection
//           OnPageView(
//             title: "Which ",
//             keyword: "muscle groups ",
//             additionalText: "would you like to train?",
//             pageController: _pageController,
//             childWidget: Container(),
//             bottomWidget: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CommonButton(
//                   width: 170,
//                   backgroundColor: Colors.white,
//                   textColor: Color(AppMethods.hexColor("#fb9b28")),
//                   text: 'Previous',
//                   borderSide: BorderSide(
//                       color: Color(AppMethods.hexColor("#fb9b28")), width: 2),
//                   onPressed: () {
//                     _pageController.previousPage(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.easeInOut);
//                   },
//                 ),
//                 CommonButton(
//                   width: 170,
//                   backgroundColor: Color(AppMethods.hexColor("#fb9b28")),
//                   textColor: AppStyle.whiteColor,
//                   text: 'Next',
//                   onPressed: () {
//                     print(_goalList[_goalListIndex]["title"]);
//                     _pageController.nextPage(
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.easeInOut);
//                   },
//                 ),
//               ],
//             ),
//           ),

//           /**
//            * Current body shape
//            */
//           // OnPageView(
//           //   canPress: true,
//           //   title: "What’s your ",
//           //   keyword: "body shape",
//           //   additionalText: "?",
//           //   pageController: _pageController,
//           //   childWidget: _slidableOptions(options: _goalList, opIndex: 0),
//           // ),

//           /**
//            * Desired body shape
//            */
//           // OnPageView(
//           //     canPress: true,
//           //     title: "What’s your ",
//           //     keyword: "desired body shape",
//           //     additionalText: "?",
//           //     pageController: _pageController,
//           //     childWidget: _slidableOptions(options: _goalList, opIndex: 0)),

//           /**
//            * Name
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "What’s your ",
//             keyword: "name",
//             additionalText: "?",
//             pageController: _pageController,
//             childWidget: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 60 * _scaleScreen),
//               child: TextField(
//                 controller: nameController,
//                 style: TextStyle(
//                     fontSize: 30 * _scaleFont,
//                     color: AppStyle.secondaryColor,
//                     fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),

//           /**
//            * Age
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "",
//             keyword: "How old ",
//             additionalText: "are you?",
//             pageController: _pageController,
//             childWidget: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 60 * _scaleScreen),
//               child: TextField(
//                 controller: ageController,
//                 style: TextStyle(
//                     fontSize: 30 * _scaleFont,
//                     color: AppStyle.secondaryColor,
//                     fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),

//           /**
//            * Height
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "What’s your ",
//             pageController: _pageController,
//             childWidget: Transform.rotate(
//               angle: -pi / 2,
//               child: Center(
//                 child: RulerPicker(
//                   controller: _currentHeightController!,
//                   beginValue: 70,
//                   endValue: 250,
//                   initValue: _currentHeightValue,
//                   rulerScaleTextStyle:
//                       const TextStyle(color: AppStyle.black1Color),
//                   scaleLineStyleList: const [
//                     ScaleLineStyle(
//                         color: Colors.grey, width: 1.5, height: 30, scale: 0),
//                     ScaleLineStyle(
//                         color: Colors.grey, width: 1, height: 25, scale: 5),
//                     ScaleLineStyle(
//                         color: Colors.grey, width: 1, height: 15, scale: -1)
//                   ],
//                   onValueChange: (value) {
//                     setState(() {
//                       value == 70
//                           ? _currentHeightValue = 70
//                           : (value == 250
//                               ? _currentHeightValue = 250
//                               : _currentHeightValue = value - 5);
//                     });
//                   },
//                   width: MediaQuery.of(context).size.width,
//                   height: 80 * _scaleScreen,
//                   rulerMarginTop: 100 * _scaleScreen,
//                   marker: Stack(
//                     alignment: Alignment.topLeft,
//                     children: [
//                       Transform.rotate(
//                         angle: pi / 2,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               _currentHeightValue.toString(),
//                               style: TextStyle(
//                                 fontSize: 30 * _scaleFont,
//                                 color: AppStyle.primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 'cm',
//                                 style: TextStyle(
//                                   fontSize: 18 * _scaleFont,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                           width: 4,
//                           height: 150,
//                           decoration: BoxDecoration(
//                               color: AppStyle.primaryColor,
//                               borderRadius: BorderRadius.circular(5))),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             keyword: "height",
//             additionalText: "?",
//           ),

//           /**
//            * Current Weight
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "What’s your ",
//             keyword: "current weight",
//             additionalText: "?",
//             pageController: _pageController,
//             childWidget: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             _currentWeightValue.toString(),
//                             style: TextStyle(
//                                 color: AppStyle.primaryColor,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 30 * _scaleFont),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               "kg",
//                               style: TextStyle(
//                                   color: AppStyle.black1Color,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: RulerPicker(
//                         controller: _currentWeightController!,
//                         beginValue: 30,
//                         endValue: 100,
//                         initValue: _currentWeightValue,
//                         rulerScaleTextStyle:
//                             const TextStyle(color: AppStyle.black1Color),
//                         scaleLineStyleList: const [
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1.5,
//                               height: 30,
//                               scale: 0),
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1,
//                               height: 25,
//                               scale: 5),
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1,
//                               height: 15,
//                               scale: -1)
//                         ],
//                         onValueChange: (value) {
//                           setState(() {
//                             value == 30
//                                 ? _currentWeightValue = 30
//                                 : (value == 100
//                                     ? _currentWeightValue = 100
//                                     : _currentWeightValue = value - 5);
//                           });
//                         },
//                         width: MediaQuery.of(context).size.width,
//                         height: 80,
//                         rulerMarginTop: 80,
//                         marker: Container(
//                             width: 4,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 color: AppStyle.primaryColor,
//                                 borderRadius: BorderRadius.circular(5))),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0),
//                         child: Text(
//                           'Current BMI',
//                           style: TextStyle(
//                             fontSize: 16 * _scaleFont,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             '17.9',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w900,
//                               color: AppStyle.primaryColor,
//                               fontSize: 30 * _scaleFont,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20 * _scaleScreen,
//                           ),
//                           Flexible(
//                             child: Text(
//                               'You have a great potential to get in a better shape, move now!',
//                               style: TextStyle(
//                                 fontSize: 14 * _scaleFont,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /**
//            * Target Weight
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "What’s your ",
//             keyword: "desired weight",
//             additionalText: "?",
//             pageController: _pageController,
//             childWidget: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             _targetWeightValue.toString(),
//                             style: TextStyle(
//                                 color: AppStyle.primaryColor,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 30 * _scaleFont),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               "kg",
//                               style: TextStyle(
//                                   color: AppStyle.black1Color,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: RulerPicker(
//                         controller: _targetWeightController!,
//                         beginValue: 30,
//                         endValue: 100,
//                         initValue: _targetWeightValue,
//                         rulerScaleTextStyle:
//                             const TextStyle(color: AppStyle.black1Color),
//                         scaleLineStyleList: const [
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1.5,
//                               height: 30,
//                               scale: 0),
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1,
//                               height: 25,
//                               scale: 5),
//                           ScaleLineStyle(
//                               color: Colors.grey,
//                               width: 1,
//                               height: 15,
//                               scale: -1)
//                         ],
//                         onValueChange: (value) {
//                           setState(() {
//                             value == 30
//                                 ? _targetWeightValue = 30
//                                 : (value == 100
//                                     ? _targetWeightValue = 100
//                                     : _targetWeightValue = value - 5);
//                           });
//                         },
//                         width: MediaQuery.of(context).size.width,
//                         height: 80,
//                         rulerMarginTop: 80,
//                         marker: Container(
//                             width: 4,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 color: AppStyle.primaryColor,
//                                 borderRadius: BorderRadius.circular(5))),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 60, horizontal: 40),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4.0),
//                           child: Row(
//                             children: [
//                               Image.asset('assets/imgs/drop.png'),
//                               const SizedBox(
//                                 width: 2,
//                               ),
//                               Text(
//                                 'Sweet choice!',
//                                 style: TextStyle(
//                                   fontSize: 16 * _scaleFont,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppStyle.primaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           'You will gain 5.4% of body weight',
//                           style: TextStyle(
//                             fontSize: 14 * _scaleFont,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /**
//            * Often work
//            */
//           OnPageView(
//             bottomWidget: CommonButton(
//               backgroundColor: _maleIsTapped == true
//                   ? Color(AppMethods.hexColor("#fb9b28"))
//                   : Colors.grey.shade400,
//               textColor: AppStyle.whiteColor,
//               text: 'Next',
//               onPressed: () {},
//             ),
//             title: "",
//             keyword: "How often ",
//             additionalText: "would you like to workout?",
//             pageController: _pageController,
//             childWidget: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   height: 283 * _scaleScreen,
//                   child: PageView.builder(
//                       controller: PageController(viewportFraction: 0.7),
//                       itemCount: 4,
//                       onPageChanged: (index) {
//                         setState(() {
//                           _selectedOften = index;
//                         });
//                       },
//                       itemBuilder: (context, index) {
//                         var _dot = _selectedOften == index ? 1 : 0.8;
//                         return TweenAnimationBuilder(
//                           duration: const Duration(milliseconds: 350),
//                           tween: Tween(begin: _dot, end: _dot),
//                           curve: Curves.ease,
//                           builder: (context, value, child) {
//                             return Transform.scale(
//                               scale: value is double ? value : 1,
//                               child: child,
//                             );
//                           },
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 350),
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 20 * _scaleScreen),
//                             width: 200 * _scaleScreen,
//                             height: 283 * _scaleScreen,
//                             decoration: BoxDecoration(
//                               borderRadius: AppStyle.appBorder,
//                               color: AppStyle.whiteColor,
//                               border: Border.all(
//                                 width: 6,
//                                 color: _selectedOften == index
//                                     ? AppStyle.primaryColor
//                                     : AppStyle.gray5Color,
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(top: 40.0, left: 40, right: 40),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppStyle.gray4Color,
//                           borderRadius: AppStyle.appBorder,
//                         ),
//                         height: 4,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ...List.generate(
//                             4,
//                             (index) => Indicator(
//                                 isActive:
//                                     _selectedOften == index ? true : false),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //Gender card
//   Widget _genderCard(
//       {required bool mainTapped,
//       required bool secondaryCheck,
//       required String gender,
//       required String imgName}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           padding: EdgeInsets.all(mainTapped == true ? 32 : 30),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                   width: 2,
//                   color: mainTapped == true
//                       ? Color(AppMethods.hexColor("fb9b28"))
//                       : secondaryCheck == true
//                           ? Colors.grey
//                           : Colors.black54),
//               borderRadius: const BorderRadius.all(Radius.circular(15))),
//           child: Image.asset(
//             "assets/imgs/$imgName",
//             height: mainTapped == true ? 105 : 100,
//           ),
//         ),
//         const SizedBox(height: 15),
//         Text(
//           gender,
//           style: TextStyle(
//               color: mainTapped == true
//                   ? Color(AppMethods.hexColor("fb9b28"))
//                   : secondaryCheck == true
//                       ? Colors.grey
//                       : Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }

//   //Slidable pageview
//   // Widget _slidableOptions(
//   //     {required List options, required CarouselController controller}) {
//   //   int opIndex = 0;
//   //   return StatefulBuilder(builder: (context, setState) {
//   //     return Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: [
//   //         Text(
//   //           options[opIndex]["title"],
//   //           style: TextStyle(
//   //               color: Color(AppMethods.hexColor("383B53")),
//   //               fontSize: 25,
//   //               fontWeight: FontWeight.bold),
//   //         ),
//   //         const SizedBox(height: 25),
//   //         CarouselSlider.builder(
//   //           carouselController: controller,
//   //           itemCount: options.length,
//   //           itemBuilder: (context, index, realIndex) {
//   //             if (index == 0) {}
//   //             opIndex = realIndex;
//   //             return _optionCard(imgName: options[opIndex]["img"]);
//   //           },
//   //           options: CarouselOptions(
//   //               autoPlay: false,
//   //               height: 283 * AppMethods.screenScale(context),
//   //               viewportFraction: 0.7,
//   //               enableInfiniteScroll: false,
//   //               enlargeCenterPage: true,
//   //               onPageChanged: (index, reason) {
//   //                 setState(() {
//   //                   opIndex = index;
//   //                 });
//   //               }),
//   //         ),
//   //         Padding(
//   //           padding: const EdgeInsets.only(top: 30.0, left: 40, right: 40),
//   //           child: Stack(
//   //             alignment: Alignment.center,
//   //             children: [
//   //               Container(
//   //                 decoration: BoxDecoration(
//   //                   color: AppStyle.gray4Color,
//   //                   borderRadius: AppStyle.appBorder,
//   //                 ),
//   //                 height: 2.5,
//   //               ),
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                 children: [
//   //                   ...List.generate(
//   //                     options.length,
//   //                     (index) =>
//   //                         Indicator(isActive: opIndex == index ? true : false),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         )
//   //       ],
//   //     );
//   //   });
//   // }

//   //Option card
//   Widget _optionCard({required String imgName}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(
//                 width: 5, color: Color(AppMethods.hexColor("fb9b28"))),
//             borderRadius: AppStyle.appBorder),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.asset('assets/imgs/$imgName', fit: BoxFit.cover),
//         ),
//       ),
//     );
//   }
// }

// //Indicator below option cards
// class Indicator extends StatelessWidget {
//   final bool _isActive;

//   const Indicator({Key? key, required bool isActive})
//       : _isActive = isActive,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 350),
//       decoration: BoxDecoration(
//         color: _isActive
//             ? Color(AppMethods.hexColor("fb9b28"))
//             : AppStyle.gray4Color,
//         borderRadius: AppStyle.appBorder,
//         border:
//             _isActive ? Border.all(color: AppStyle.whiteColor, width: 2) : null,
//         boxShadow: _isActive
//             ? [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 0,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ]
//             : null,
//       ),
//       width: _isActive ? 18 : 15,
//       height: _isActive ? 18 : 15,
//     );
//   }
// }

// //On pageview elements
// class OnPageView extends StatefulWidget {
//   final String title;
//   final Widget childWidget;
//   final Widget bottomWidget;
//   final String keyword;
//   final String additionalText;
//   final PageController pageController;

//   const OnPageView(
//       {Key? key,
//       required this.title,
//       required this.childWidget,
//       required this.keyword,
//       required this.additionalText,
//       required this.pageController,
//       required this.bottomWidget})
//       : super(key: key);

//   @override
//   State<OnPageView> createState() => _OnPageViewState();
// }

// class _OnPageViewState extends State<OnPageView> {
//   @override
//   Widget build(BuildContext context) {
//     final _scale = AppMethods.screenScale(context);
//     return Container(
//       decoration: const BoxDecoration(
//         color: AppStyle.whiteColor,
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 70 * _scale),
//           Padding(
//             padding: EdgeInsets.only(left: 30 * _scale, right: 30 * _scale),
//             child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     style: TextStyle(
//                         fontFamily: "OpenSans",
//                         color: Color(AppMethods.hexColor("#383B53")),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25 * AppMethods.fontScale(context)),
//                     children: [
//                       TextSpan(text: widget.title),
//                       TextSpan(
//                           text: widget.keyword,
//                           style: TextStyle(
//                               color: Color(AppMethods.hexColor("#fb9b28")),
//                               fontWeight: FontWeight.bold)),
//                       TextSpan(text: widget.additionalText)
//                     ])),
//           ),
//           Expanded(
//             child: Padding(
//                 padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                 child: widget.childWidget),
//           ),
//           Padding(
//               padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
//               child: widget.bottomWidget),
//         ],
//       ),
//     );
//   }
// }
