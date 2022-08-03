// ignore_for_file: file_names

import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/User.dart';
import 'package:beefit/screens/Daily/DailyScreen.dart';
import 'package:beefit/screens/HomeScreen.dart';
import 'package:beefit/screens/Plan/PlanScreen.dart';
import 'package:beefit/screens/SettingScreen.dart';
import 'package:custom_top_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Exercise/ExerciseScreen.dart';
import 'dart:convert';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      name: prefs.getString(AppMethods.NAME),
      gender: prefs.getBool(AppMethods.IS_MALE),
      age: prefs.getInt(AppMethods.AGE),
      height: prefs.getInt(AppMethods.HEIGHT),
      weight: prefs.getInt(AppMethods.CURRENT_WEIGHT),
      goal: prefs.getInt(AppMethods.GOAL),
      level: prefs.getInt(AppMethods.LEVEL),
      bmr: prefs.getDouble(AppMethods.BMR), 
      bmi: prefs.getDouble(AppMethods.BMI),
      muscleId: prefs.getInt(AppMethods.MUSCLES),
      mainPlan: prefs.getInt(AppMethods.MAINPLAN),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          User _user = snapshot.data as User;
          List<Widget> _pageOption = <Widget>[
            HomeScreen(user: _user),
            ExerciseScreen(user: _user),
            PlanScreen(user: _user),
            DailyScreen(user: _user),
            SettingScreen(user: _user),
          ];
          return CustomScaffold(
            scaffold: Scaffold(
              backgroundColor: AppStyle.whiteColor,
              body: _pageOption.elementAt(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppStyle.whiteColor,
                elevation: 10,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
// backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      'assets/imgs/svg/home.svg',
                      color: _selectedIndex == 0
                          ? AppStyle.primaryColor
                          : AppStyle.gray4Color,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/imgs/svg/exercise.svg',
                      color: _selectedIndex == 1
                          ? AppStyle.primaryColor
                          : AppStyle.gray4Color,
                    ),
                    label: 'Exercise',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/imgs/svg/plan.svg',
                      color: _selectedIndex == 2
                          ? AppStyle.primaryColor
                          : AppStyle.gray4Color,
                    ),
                    label: 'Plan',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/imgs/svg/daily.svg',
                      color: _selectedIndex == 3
                          ? AppStyle.primaryColor
                          : AppStyle.gray4Color,
                    ),
                    label: 'Daily',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/imgs/svg/setting.svg',
                      color: _selectedIndex == 4
                          ? AppStyle.primaryColor
                          : AppStyle.gray4Color,
                    ),
                    label: 'User',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            ),
            children: [
              HomeScreen(user: _user),
              ExerciseScreen(user: _user),
              PlanScreen(user: _user),
              DailyScreen(user: _user),
              SettingScreen(user: _user),
            ],
            onItemTap: _onItemTapped,
          );
        });
  }
}
