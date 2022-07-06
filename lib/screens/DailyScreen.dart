import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/AddFoodScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/AppMethods.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({Key? key}) : super(key: key);

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Workout'),
          Tab(text: 'Nutrition'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppStyle.whiteColor,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 30,
          backgroundColor: AppStyle.whiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: AppStyle.secondaryColor,
                  fontSize: 24 * _scaleFont,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 24 * _scaleScreen,
                  color: AppStyle.secondaryColor,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppStyle.gray5Color.withOpacity(0.5),
                borderRadius: AppStyle.appBorder,
              ),
              child: TabBar(
                tabs: const [
                  Tab(text: 'Workout'),
                  Tab(text: 'Nutrition'),
                ],
                // padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                indicator: BoxDecoration(
                  color: AppStyle.primaryColor,
                  borderRadius: AppStyle.appBorder,
                ),
                unselectedLabelColor: AppStyle.black1Color,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14 * _scaleFont,
                  fontWeight: FontWeight.w700,
                ),
                isScrollable: true,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * _scaleScreen,
                          vertical: 16 * _scaleScreen),
                      margin: EdgeInsets.symmetric(vertical: 16 * _scaleScreen),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                        color: AppStyle.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                'Workout',
                                style: GoogleFonts.poppins(
                                  color: AppStyle.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '0',
                                style: GoogleFonts.poppins(
                                  color: AppStyle.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'kcal',
                                  style: GoogleFonts.poppins(
                                    color: AppStyle.whiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '0',
                                  style: GoogleFonts.poppins(
                                    color: AppStyle.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: AppStyle.gray5Color, width: 1),
                                left: BorderSide(
                                    color: AppStyle.gray5Color, width: 1),
                              ),
                            ),
                          )),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Time (min)',
                                  style: GoogleFonts.poppins(
                                    color: AppStyle.whiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '0',
                                  style: GoogleFonts.poppins(
                                    color: AppStyle.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      calendarStyle: CalendarStyle(),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30 * _scaleScreen, vertical: 20 * _scaleScreen),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * _scaleScreen,
                          vertical: 16 * _scaleScreen),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppStyle.secondaryColor,
                        borderRadius: AppStyle.appBorder,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: AppStyle.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16 * _scaleScreen,
                                vertical: 16 * _scaleScreen),
                            margin: EdgeInsets.only(bottom: 8 * _scaleScreen),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Image.asset('assets/imgs/eat.png'),
                                    Text(
                                      '860',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppStyle.secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Ate',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: AppStyle.infoColor,
                                      ),
                                    ),
                                  ],
                                )),
                                CircularPercentIndicator(
                                  radius: 68 * AppMethods.screenScale(context),
                                  lineWidth: 15,
                                  animation: true,
                                  percent: 0.7,
                                  center: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1625",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: (26.0 *
                                                AppMethods.fontScale(context)),
                                            color: AppStyle.primaryColor),
                                      ),
                                      Text(
                                        "kCal Left",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: (12 *
                                                AppMethods.fontScale(context)),
                                            color: AppStyle.secondaryColor),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xffebebeb),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: AppStyle.primaryColor,
                                  animationDuration: 1000,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Image.asset('assets/imgs/burn.png'),
                                    Text(
                                      '120',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppStyle.secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      'Burned',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: AppStyle.errorColor,
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppStyle.whiteColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10 * _scaleScreen, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Carb',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4 * _scaleScreen),
                                          child: const LinearProgressIndicator(
                                            backgroundColor:
                                                AppStyle.gray5Color,
                                            color: AppStyle.primaryColor,
                                            value: 46 / 158,
                                          ),
                                        ),
                                        Text(
                                          '46 / 158',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Protein',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4 * _scaleScreen),
                                          child: const LinearProgressIndicator(
                                            backgroundColor:
                                                AppStyle.gray5Color,
                                            color: AppStyle.primaryColor,
                                            value: 46 / 158,
                                          ),
                                        ),
                                        Text(
                                          '46 / 158',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Fat',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4 * _scaleScreen),
                                          child: const LinearProgressIndicator(
                                            backgroundColor:
                                                AppStyle.gray5Color,
                                            color: AppStyle.primaryColor,
                                            value: 46 / 158,
                                          ),
                                        ),
                                        Text(
                                          '46 / 158',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12 * _scaleFont),
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
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8 * _scaleScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your food log',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: AppStyle.secondaryColor,
                              fontSize: 16 * _scaleFont,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 16 * _scaleScreen,
                                  color: AppStyle.secondaryColor,
                                ),
                                Text(
                                  'Meal',
                                  style: GoogleFonts.poppins(
                                    color: AppStyle.secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: AppStyle.gray5Color.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                      padding: EdgeInsets.symmetric(
                          vertical: 12 * _scaleScreen,
                          horizontal: 16 * _scaleScreen),
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                        color: AppStyle.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppStyle.gray5Color.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.asset("assets/imgs/breakfast.png"),
                            title: Text(
                              'Breakfast',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.secondaryColor),
                            ),
                            contentPadding: EdgeInsets.zero,
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddFoodScreen()),
                                );
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: AppStyle.primaryColor,
                                size: 30 * _scaleScreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                      padding: EdgeInsets.symmetric(
                          vertical: 12 * _scaleScreen,
                          horizontal: 16 * _scaleScreen),
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                        color: AppStyle.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppStyle.gray5Color.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.asset("assets/imgs/lunch.png"),
                            title: Text(
                              'Lunch',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.secondaryColor),
                            ),
                            contentPadding: EdgeInsets.zero,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle,
                                color: AppStyle.primaryColor,
                                size: 30 * _scaleScreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                      padding: EdgeInsets.symmetric(
                          vertical: 12 * _scaleScreen,
                          horizontal: 16 * _scaleScreen),
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                        color: AppStyle.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppStyle.gray5Color.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.asset("assets/imgs/dinner.png"),
                            title: Text(
                              'Dinner',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.secondaryColor),
                            ),
                            contentPadding: EdgeInsets.zero,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle,
                                color: AppStyle.primaryColor,
                                size: 30 * _scaleScreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
