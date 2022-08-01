// ignore_for_file: file_names

import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/User.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/AppMethods.dart';
import 'package:beefit/controls/utils.dart';

class HomeScreen extends StatefulWidget {
  final User _user;
  const HomeScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user = widget._user;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

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
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              headerVisible: false,
              focusedDay: _focusedDay.value,
              calendarFormat: CalendarFormat.week,
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppStyle.secondaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppStyle.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              height: 190 * _scaleScreen,
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
                padding: EdgeInsets.symmetric(
                    vertical: 10 * _scaleScreen, horizontal: 16 * _scaleScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              SizedBox(
                                  width: 100 * _scaleScreen,
                                  child: LinearProgressIndicator(
                                    value: 0.7,
                                    backgroundColor:
                                        AppStyle.infoColor.withOpacity(0.3),
                                    color: AppStyle.infoColor,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    user.bmr.toString(),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10 * _scaleScreen),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppStyle.errorColor,
                                      width: 2 * _scaleScreen))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/imgs/svg/run.svg',
                                  ),
                                  SizedBox(
                                    width: 4 * _scaleScreen,
                                  ),
                                  Text(
                                    'Burned',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14 * _scaleScreen,
                                      color: AppStyle.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: 100 * _scaleScreen,
                                  child: LinearProgressIndicator(
                                    value: 0.7,
                                    backgroundColor:
                                        AppStyle.errorColor.withOpacity(0.3),
                                    color: AppStyle.errorColor,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    '1200',
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
                            user.bmr!.ceil().toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    (26.0 * AppMethods.fontScale(context)),
                                color: AppStyle.secondaryColor),
                          ),
                          Text(
                            "kCal Left",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: (12 * AppMethods.fontScale(context)),
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
                child: ClipRRect(
                  borderRadius: AppStyle.appBorder,
                  child: Stack(
                    children: [
                      Image.asset('assets/imgs/fitness1.png',
                          width: double.infinity, fit: BoxFit.fill),
                      Image.asset('assets/imgs/appbarBackground.png',
                          width: double.infinity, fit: BoxFit.fill),
                      Container(
                        padding: EdgeInsets.all(18 * _scaleScreen),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppStyle.primaryColor.withOpacity(0.6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Massive upper body',
                              style: GoogleFonts.poppins(
                                color: AppStyle.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24 * _scaleFont,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0 * _scaleScreen),
                              child: Text(
                                'Each workout in this plan is devoted to a major upper body muscle group – your chest, back and shoulders',
                                style: GoogleFonts.poppins(
                                  color: AppStyle.whiteColor,
                                  fontSize: 14 * _scaleFont,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CommonButton(
                              onPressed: () {},
                              backgroundColor: AppStyle.whiteColor,
                              text: 'START',
                              textColor: AppStyle.primaryColor,
                              elevation: 0,
                              height: 40 * _scaleScreen,
                              // width: 200 * _scaleScreen,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
