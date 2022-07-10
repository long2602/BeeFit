// ignore_for_file: file_names

import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/AppMethods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatePickerController _datePickerController = DatePickerController();
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Welcome back, Long',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 20 * _scaleFont,
                  )),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: 24 * _scaleScreen,
                  color: AppStyle.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
        child: Column(
          children: [
            DatePicker(
              DateTime.now().subtract(const Duration(days: 1)),
              width: 55 * _scaleScreen,
              height: 90 * _scaleScreen,
              controller: _datePickerController,
              initialSelectedDate: DateTime.now(),
              selectionColor: AppStyle.primaryColor,
              selectedTextColor: AppStyle.whiteColor,
              dateTextStyle: TextStyle(
                color: AppStyle.black1Color.withOpacity(.25),
                fontSize: 18 * _scaleFont,
                fontWeight: FontWeight.w700,
              ),
              dayTextStyle: TextStyle(
                color: AppStyle.black1Color.withOpacity(.25),
                fontSize: 12 * _scaleFont,
              ),
              monthTextStyle: TextStyle(
                color: AppStyle.black1Color.withOpacity(.25),
                fontSize: 12 * _scaleFont,
              ),
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: AppStyle.appBorder,
                  color: AppStyle.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppStyle.gray5Color.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16 * _scaleScreen),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10 * _scaleScreen),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: AppStyle.infoColor,
                                        width: 2 * _scaleScreen))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/imgs/svg/food.svg',
                                    ),
                                    SizedBox(
                                      width: 4 * _scaleScreen,
                                    ),
                                    Text(
                                      'Eaten',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14 * _scaleScreen,
                                        color: AppStyle.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                // LinearProgressIndicator(
                                //   backgroundColor: AppStyle.gray5Color,
                                //   color: AppStyle.primaryColor,
                                //   value: 46 / 158,
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      '1265',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20 * _scaleScreen,
                                        color: AppStyle.secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4 * _scaleScreen,
                                    ),
                                    Text(
                                      'kCal',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14 * _scaleScreen,
                                        color: AppStyle.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 68 * AppMethods.screenScale(context),
                        lineWidth: 15,
                        animation: true,
                        percent: 0.7,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1625",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      (26.0 * AppMethods.fontScale(context)),
                                  color: AppStyle.primaryColor),
                            ),
                            Text(
                              "kCal Left",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      (12 * AppMethods.fontScale(context)),
                                  color: AppStyle.secondaryColor),
                            ),
                          ],
                        ),
                        backgroundColor: const Color(0xffebebeb),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: AppStyle.primaryColor,
                        animationDuration: 1000,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Plan',
                  style: GoogleFonts.poppins(
                    color: AppStyle.secondaryColor,
                    fontSize: 14 * _scaleFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'All Plans',
                    style: GoogleFonts.poppins(
                      color: AppStyle.primaryColor,
                      fontSize: 14 * _scaleFont,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset('assets/imgs/fitness1.png',
                    width: double.infinity, fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16 * _scaleScreen),
              child: ButtonMain(
                onPressed: () {},
                backgroundColor: AppStyle.gray5Color,
                text: 'Explore all plans',
                textColor: AppStyle.gray2Color,
                height: 40 * _scaleScreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
