// ignore_for_file: file_names

import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/User.dart';
import 'package:beefit/screens/Plan/PlanScreen.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/AppMethods.dart';
import 'package:beefit/controls/utils.dart';
import 'package:intl/intl.dart';
import '../models/PlamExerciseDetail.dart';
import '../models/challenge.dart';
import '../models/databaseHelper.dart';
import '../models/food_history.dart';
import '../models/plan.dart';
import 'Plan/DetailChallengeScreen.dart';

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
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<Challenge> listChallenges = [];

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
              Text('Welcome back, ${widget._user.name}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 20 * _scaleFont,
                  )),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future: Future.wait([
            databaseHelper.getPlanById(1000),
            databaseHelper.getPlanDayByDate(formattedDate),
            databaseHelper.getFoodHistoryByDay(formattedDate),
            databaseHelper.getChallenges(),
          ]),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            Plan plan = snapshot.data![0] as Plan;
            List<PlanExerciseDetail> list =
                snapshot.data![1] as List<PlanExerciseDetail>;
            double totalCalo = 0;
            double totalEat = 0;
            for (PlanExerciseDetail item in list) {
              totalCalo += item.kcal!;
            }
            print(totalCalo);
            List<FoodHistory> listFood = snapshot.data![2] as List<FoodHistory>;
            for (FoodHistory item in listFood) {
              totalEat += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Calories')
                  .amount);
            }
            print(totalEat);
            listChallenges = snapshot.data![3] as List<Challenge>;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      // height: 250 * _scaleScreen,
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20 * _scaleScreen,
                            horizontal: 18 * _scaleScreen),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calories',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 22 * _scaleFont,
                              ),
                            ),
                            Text(
                              'Remaining = Goal - Eaten + Burned',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 14 * _scaleFont,
                                color: AppStyle.gray1Color,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10 * _scaleScreen),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppStyle.gray4Color,
                                                  width: 2 * _scaleScreen))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.flag,
                                                color: AppStyle.gray4Color,
                                                size: 22,
                                              ),
                                              SizedBox(
                                                width: 4 * _scaleScreen,
                                              ),
                                              Text(
                                                'Base Goal',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: 100 * _scaleScreen,
                                              child: LinearProgressIndicator(
                                                value: 0,
                                                backgroundColor: AppStyle
                                                    .gray4Color
                                                    .withOpacity(0.3),
                                                color: AppStyle.gray4Color,
                                              )),
                                          Row(
                                            children: [
                                              Text(
                                                user.bmr!.ceil().toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4 * _scaleScreen,
                                              ),
                                              Text(
                                                'kCal',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10 * _scaleScreen),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppStyle.infoColor,
                                                  width: 2 * _scaleScreen))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: 100 * _scaleScreen,
                                              child: LinearProgressIndicator(
                                                value: (totalEat / user.bmr!) >
                                                        1
                                                    ? 1
                                                    : (totalEat / user.bmr!),
                                                backgroundColor: AppStyle
                                                    .infoColor
                                                    .withOpacity(0.3),
                                                color: AppStyle.infoColor,
                                              )),
                                          Row(
                                            children: [
                                              Text(
                                                totalEat.ceil().toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4 * _scaleScreen,
                                              ),
                                              Text(
                                                'kCal',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: 100 * _scaleScreen,
                                              child: LinearProgressIndicator(
                                                value: totalCalo / user.bmr!,
                                                backgroundColor: AppStyle
                                                    .errorColor
                                                    .withOpacity(0.3),
                                                color: AppStyle.errorColor,
                                              )),
                                          Row(
                                            children: [
                                              Text(
                                                totalCalo.ceil().toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4 * _scaleScreen,
                                              ),
                                              Text(
                                                'kCal',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14 * _scaleScreen,
                                                  color:
                                                      AppStyle.secondaryColor,
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
                                  radius: 75 * AppMethods.screenScale(context),
                                  lineWidth: 12,
                                  animation: true,
                                  percent: (user.bmr! - totalEat + totalCalo) /
                                      user.bmr!,
                                  center: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (user.bmr!.ceil() +
                                                totalCalo.ceil() -
                                                totalEat.ceil())
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: (26.0 *
                                                AppMethods.fontScale(context)),
                                            color: AppStyle.secondaryColor),
                                      ),
                                      Text(
                                        "Remaining",
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'My Plan',
                        style: GoogleFonts.poppins(
                          color: AppStyle.secondaryColor,
                          fontSize: 14 * _scaleFont,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 250 * _scaleScreen,
                      margin: EdgeInsets.only(bottom: 16 * _scaleScreen),
                      decoration: BoxDecoration(
                        borderRadius: AppStyle.appBorder,
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/imgs/${plan.img}.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: double.infinity,
                          ),
                          Image.asset(
                            'assets/imgs/appbarBackground.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: double.infinity,
                          ),
                          Container(
                            padding: EdgeInsets.all(18 * _scaleScreen),
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppStyle.primaryColor.withOpacity(0.6),
                              borderRadius: AppStyle.appBorder,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  plan.name,
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
                                    plan.des,
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
                    Text(
                      'All Challenges',
                      style: GoogleFonts.poppins(
                        color: AppStyle.secondaryColor,
                        fontSize: 14 * _scaleFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listChallenges.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailChallengeScreen(
                                          challenge: listChallenges[index],
                                          user: widget._user,
                                        )),
                              );
                            },
                            child: Container(
                              height: 120,
                              width: 220,
                              margin: EdgeInsets.only(right: 12 * _scaleScreen),
                              child: ClipRRect(
                                borderRadius: AppStyle.appBorder,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/imgs/${listChallenges[index].image}.png',
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: AppStyle.appBorder,
                                          color: AppStyle.gray5Color
                                              .withOpacity(0.6)),
                                      child: Text(
                                        listChallenges[index].name,
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.poppins(
                                          color: AppStyle.black1Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16 * _scaleScreen),
                      child: ButtonMain(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlanScreen(user: user),
                            ),
                          );
                        },
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
          }),
    );
  }
}
