import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/food_history.dart';
import 'package:beefit/screens/Daily/AddFoodScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beefit/controls/utils.dart';
import 'dart:collection';
import '../../constants/AppMethods.dart';
import '../../models/PlanExerciseDetail.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import 'package:intl/intl.dart';
import 'DetailFoodScreen.dart';

class DailyScreen extends StatefulWidget {
  final User _user;
  const DailyScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  late final PageController _pageController;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<FoodHistory> listBreakfast = [];
  List<FoodHistory> listLunch = [];
  List<FoodHistory> listDinner = [];
  List<FoodHistory> listFood = [];
  List<PlanExerciseDetail> listExercise = [];
  late User user;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  double _totalExercise = 0;
  double _totalEat = 0;
  double _totalTime = 0;
  double defaultCarb = 0;
  double defaultProtein = 0;
  double defaultFat = 0;

  macroNutrition(int userLevel) {
    if (userLevel == 1) {
      defaultCarb = user.bmr! * 0.3;
      defaultFat = user.bmr! * 0.3;
      defaultProtein = user.bmr! * 0.4;
    } else if (userLevel == 2) {
      defaultCarb = user.bmr! * 0.35;
      defaultFat = user.bmr! * 0.35;
      defaultProtein = user.bmr! * 0.3;
    } else {
      defaultCarb = user.bmr! * 0.3;
      defaultFat = user.bmr! * 0.2;
      defaultProtein = user.bmr! * 0.5;
    }
  }

  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Workout'),
          Tab(text: 'Nutrition'),
        ],
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
    user = widget._user;
    macroNutrition(user.level!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusedDay.dispose();
    _selectedEvents.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  double value(double _totalEat, double _totalCalo) {
    double temp = (user.bmr! - _totalEat + _totalCalo);
    print(temp);
    if (temp < 0) {
      return 1;
    } else if (temp > user.bmr!) {
      return 1;
    }
    return (user.bmr! - _totalEat + _totalCalo).abs() / user.bmr!;
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
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
          ],
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          databaseHelper.getPlanDayByDate(formattedDate),
          databaseHelper.getFoodHistoryByDay(formattedDate),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          _totalExercise = 0;
          _totalEat = 0;
          _totalTime = 0;
          listExercise = snapshot.data![0] as List<PlanExerciseDetail>;

          for (PlanExerciseDetail item in listExercise) {
            _totalExercise += item.kcal!;
            if (item.isRepCount == 0) {
              _totalTime += (item.duration! + item.restDuration!);
            } else {
              _totalTime += (item.rep! + 3 + item.restDuration!);
            }
          }
          listFood = snapshot.data![1] as List<FoodHistory>;
          for (FoodHistory item in listFood) {
            _totalEat += (item.ingredient.nutrition!.Nutrients
                .firstWhere((element) => element.name == 'Calories')
                .amount);
          }
          return nutritionTab(_scaleScreen, _scaleFont);
        },
      ),
    );
  }

  SingleChildScrollView nutritionTab(double _scaleScreen, double _scaleFont) {
    num totalCarb = 0, totalProtein = 0, totalFat = 0;
    int id = 0;
    void refreshData() {
      id++;
    }

    onGoBack(dynamic value) {
      refreshData();
      setState(() {});
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30 * _scaleScreen, vertical: 20 * _scaleScreen),
        child: FutureBuilder(
          future: Future.wait([
            databaseHelper.getFoodHistoryByMealAndDay(1, formattedDate),
            databaseHelper.getFoodHistoryByMealAndDay(2, formattedDate),
            databaseHelper.getFoodHistoryByMealAndDay(3, formattedDate),
          ]),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            listBreakfast = snapshot.data![0] as List<FoodHistory>;
            listLunch = snapshot.data![1] as List<FoodHistory>;
            listDinner = snapshot.data![2] as List<FoodHistory>;

            for (FoodHistory item in listBreakfast) {
              totalProtein += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Protein')
                  .amount);
              totalFat += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Calories')
                  .amount);
              totalCarb += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Carbohydrates')
                  .amount);
            }
            for (FoodHistory item in listDinner) {
              totalProtein += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Protein')
                  .amount);
              totalFat += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Calories')
                  .amount);
              totalCarb += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Carbohydrates')
                  .amount);
            }
            for (FoodHistory item in listLunch) {
              totalProtein += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Protein')
                  .amount);
              totalFat += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Calories')
                  .amount);
              totalCarb += (item.ingredient.nutrition!.Nutrients
                  .firstWhere((element) => element.name == 'Carbohydrates')
                  .amount);
            }

            return Column(
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
                                  _totalEat.ceil().toString(),
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
                              radius: 72 * AppMethods.screenScale(context),
                              lineWidth: 12,
                              animation: true,
                              percent: value(_totalEat, _totalExercise),
                              center: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (user.bmr! - _totalEat + _totalExercise)
                                        .ceil()
                                        .abs()
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: (26.0 *
                                            AppMethods.fontScale(context)),
                                        color: AppStyle.primaryColor),
                                  ),
                                  Text(
                                    (user.bmr! - _totalEat + _totalExercise) >=
                                            0
                                        ? "Remaining"
                                        : 'Over',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (12 *
                                            AppMethods.fontScale(context)),
                                        color: AppStyle.secondaryColor),
                                  ),
                                ],
                              ),
                              backgroundColor:
                                  (user.bmr! - _totalEat + _totalExercise) >= 0
                                      ? const Color(0xffebebeb)
                                      : AppStyle.primaryColor,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor:
                                  (user.bmr! - _totalEat + _totalExercise) >= 0
                                      ? AppStyle.primaryColor
                                      : AppStyle.primaryColor,
                              animationDuration: 1000,
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Image.asset('assets/imgs/burn.png'),
                                Text(
                                  _totalExercise.ceil().toString(),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                      child: LinearProgressIndicator(
                                        backgroundColor: AppStyle.gray5Color,
                                        color: AppStyle.primaryColor,
                                        value: totalCarb / defaultCarb > 1
                                            ? 1
                                            : (totalCarb / defaultCarb),
                                      ),
                                    ),
                                    Text(
                                      '${totalCarb.ceil()} / ${defaultCarb.ceil()}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12 * _scaleFont),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                      child: LinearProgressIndicator(
                                        backgroundColor: AppStyle.gray5Color,
                                        color: AppStyle.primaryColor,
                                        value:
                                            (totalProtein / defaultProtein) > 1
                                                ? 1
                                                : (totalCarb / defaultCarb),
                                      ),
                                    ),
                                    Text(
                                      '${totalProtein.ceil()} / ${defaultProtein.ceil()}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12 * _scaleFont),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                      child: LinearProgressIndicator(
                                        backgroundColor: AppStyle.gray5Color,
                                        color: AppStyle.primaryColor,
                                        value: (totalFat / defaultProtein) > 1
                                            ? 1
                                            : (totalFat / defaultProtein),
                                      ),
                                    ),
                                    Text(
                                      '${totalFat.ceil()} / ${defaultFat.ceil()}',
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
                        offset:
                            const Offset(0, 2), // changes position of shadow
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
                          onPressed: () async {
                            bool received = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddFoodScreen(
                                        title: "Breakfast",
                                      )),
                            );
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: AppStyle.primaryColor,
                            size: 30 * _scaleScreen,
                          ),
                        ),
                      ),
                      for (FoodHistory item in listBreakfast)
                        ListTile(
                          leading: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              databaseHelper
                                  .deleteRaw(item.id!, "food_history", "idfood")
                                  .then((value) {
                                setState(() {});
                              });
                            },
                          ),
                          title: Text(
                            item.ingredient.name!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: AppStyle.black3Color,
                              fontSize: 14 * _scaleFont,
                            ),
                          ),
                          trailing: Text(
                            '${item.ingredient.nutrition!.Nutrients.firstWhere((element) => element.name == 'Calories').amount.ceil()} kcal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: AppStyle.primaryColor,
                              fontSize: 16 * _scaleFont,
                            ),
                          ),
                          subtitle: Text('${item.ingredient.amount!.ceil()}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailFoodScreen(
                                        ingredient: item.ingredient,
                                        meal: item.meal!,
                                      )),
                            );
                          },
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
                        offset:
                            const Offset(0, 2), // changes position of shadow
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddFoodScreen(
                                        title: "Lunch",
                                      )),
                            );
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: AppStyle.primaryColor,
                            size: 30 * _scaleScreen,
                          ),
                        ),
                      ),
                      for (FoodHistory item in listLunch)
                        ListTile(
                          title: Text(
                            item.ingredient.name!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: AppStyle.black3Color,
                              fontSize: 14 * _scaleFont,
                            ),
                          ),
                          trailing: Text(
                            '${item.ingredient.nutrition!.Nutrients.firstWhere((element) => element.name == 'Calories').amount}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: AppStyle.primaryColor,
                              fontSize: 12 * _scaleFont,
                            ),
                          ),
                          onTap: () {},
                        )
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
                        offset:
                            const Offset(0, 2), // changes position of shadow
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddFoodScreen(
                                        title: "Dinner",
                                      )),
                            );
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: AppStyle.primaryColor,
                            size: 30 * _scaleScreen,
                          ),
                        ),
                      ),
                      for (FoodHistory item in listDinner)
                        ListTile(
                          title: Text(
                            item.ingredient.name!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: AppStyle.black3Color,
                              fontSize: 14 * _scaleFont,
                            ),
                          ),
                          trailing: Text(
                            '${item.ingredient.nutrition!.Nutrients.firstWhere((element) => element.name == 'Calories').amount}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: AppStyle.primaryColor,
                              fontSize: 12 * _scaleFont,
                            ),
                          ),
                          onTap: () {},
                        )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
