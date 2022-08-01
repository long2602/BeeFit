// ignore_for_file: file_names

import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/screens/AppScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/AppStyles.dart';
import 'dart:convert';

class OnProgressScreen extends StatefulWidget {
  const OnProgressScreen(
      {required bool isMale,
      required int height,
      required int currentWeight,
      required String name,
      required int age,
      required int level,
      required double bmi,
      required double bmr,
      required int goal,
      required Map<String, bool> muscles,
      Key? key})
      : _name = name,
        _height = height,
        _age = age,
        _currentWeight = currentWeight,
        _isMale = isMale,
        _level = level,
        _bmi = bmi,
        _bmr = bmr,
        _goal = goal,
        _muscles = muscles,
        super(key: key);
  final bool _isMale;
  final int _height, _currentWeight, _age, _level, _goal;
  final String _name;
  final double _bmi, _bmr;
  final Map<String, bool>? _muscles;

  @override
  State<OnProgressScreen> createState() => _OnProgressScreenState();
}

class _OnProgressScreenState extends State<OnProgressScreen> {
  Future<bool> saveInfoUser({
    required bool isMale,
    required int height,
    required int currentWeight,
    required String name,
    required int age,
    required int level,
    required double bmi,
    required double bmr,
    required int goal,
    required Map<String, dynamic> muscles,
    required int mainPlan,
  }) async {
    bool isSuccess = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(AppMethods.Is_FIRSTTIME, true);
      prefs.setString(AppMethods.NAME, name);
      prefs.setInt(AppMethods.AGE, age);
      prefs.setInt(AppMethods.CURRENT_WEIGHT, currentWeight);
      prefs.setInt(AppMethods.HEIGHT, height);
      prefs.setBool(AppMethods.IS_MALE, isMale);
      prefs.setInt(AppMethods.LEVEL, level);
      prefs.setInt(AppMethods.GOAL, goal);
      prefs.setDouble(AppMethods.BMI, bmi);
      prefs.setDouble(AppMethods.BMR, bmr);
      prefs.setString(AppMethods.MUSCLES, json.encode(muscles));
      prefs.setInt(AppMethods.MAINPLAN, mainPlan);
      return true;
    } catch (e) {
      print("[RESULT]: fail - " + e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _scaleScreen = AppMethods.screenScale(context);
    double _scaleFont = AppMethods.fontScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
      ),
      body: FutureBuilder(
        future: saveInfoUser(
          isMale: widget._isMale,
          height: widget._height,
          currentWeight: widget._currentWeight,
          name: widget._name,
          age: widget._age,
          level: widget._level,
          bmi: widget._bmi,
          bmr: widget._bmr,
          goal: widget._goal,
          muscles: widget._muscles!,
          mainPlan: 999,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 52, vertical: 52),
                    child: Text(
                      "We are creating plans for you...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: AppStyle.secondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xffebebeb),
                      color: AppStyle.primaryColor,
                      strokeWidth: 10,
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 52 * _scaleScreen,
                    vertical: 100 * _scaleScreen),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 100 * _scaleScreen),
                            child: SvgPicture.asset(
                              'assets/imgs/svg/checked.svg',
                              width: 150 * _scaleScreen,
                              height: 150 * _scaleScreen,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15 * _scaleScreen),
                            child: Text(
                              'Welcome, ${widget._name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40 * _scaleFont,
                                color: AppStyle.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15 * _scaleScreen),
                            child: Text(
                              'You are on set now, let’s reach your goals together with us.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22 * _scaleFont,
                                color: AppStyle.secondaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                        backgroundColor: AppStyle.primaryColor,
                        textColor: AppStyle.whiteColor,
                        text: 'Go to home',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AppScreen()),
                          );
                        }),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 52, vertical: 52),
                child: Text(
                  "We are creating plans for you...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: AppStyle.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffebebeb),
                  color: AppStyle.primaryColor,
                  strokeWidth: 10,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
