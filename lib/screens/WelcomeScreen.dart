import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/AppScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../constants/AppMethods.dart';
import '../widgets/CommonButton.dart';

class WelcomeScreen extends StatelessWidget {
  final String _name;

  const WelcomeScreen({Key? key, required String name})
      : _name = name,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double _scaleScreen = AppMethods.screenScale(context);
    double _scaleFont = AppMethods.fontScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        backgroundColor: AppStyle.whiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 52 * _scaleScreen, vertical: 100 * _scaleScreen),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 100 * _scaleScreen),
                    child: SvgPicture.asset(
                      'assets/imgs/svg/checked.svg',
                      width: 150 * _scaleScreen,
                      height: 150 * _scaleScreen,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15 * _scaleScreen),
                    child: Text(
                      'Welcome, $_name!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40 * _scaleFont,
                        color: AppStyle.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15 * _scaleScreen),
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
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("firstTime", true);
                Get.to(const AppScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
