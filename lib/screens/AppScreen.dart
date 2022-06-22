import 'package:beefit/constants/app_style.dart';
import 'package:beefit/screens/HomeScreen.dart';
import 'package:beefit/screens/PlanScreen.dart';
import 'package:beefit/screens/testData.dart';
import 'package:custom_top_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ExerciseScreen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _pageOption = <Widget>[
    const HomeScreen(),
    const ExerciseScreen(),
    const PlanScreen(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      children: [
        const HomeScreen(),
        const ExerciseScreen(),
        const PlanScreen(),
        const TestData(),
        Container(),
      ],
      onItemTap: _onItemTapped,
    );

  }
}