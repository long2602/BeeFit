import 'package:beefit/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _pageOption = <Widget>[
    Container(),
    Container(),
    Container(),
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
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: Center(
        child: _pageOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: AppStyle.gray5Color,
              blurRadius: 5.0,
              offset: Offset(5.0, 5.0),
              spreadRadius: 5,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
