import 'package:beefit/constants/app_style.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_methods.dart';

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
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppStyle.whiteColor,
                borderRadius: AppStyle.appBorder,
                boxShadow: const [
                  BoxShadow(
                    color: AppStyle.gray5Color,
                    blurRadius: 20.0,
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [

                ],
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset('assets/imgs/fitness1.png'),
            ),
            ButtonMain(
              onPressed: () {},
              backgroundColor: AppStyle.gray5Color,
              text: 'Explore all plans',
              textColor: AppStyle.black1Color,
              height: 40 * _scaleScreen,
            ),
          ],
        ),
      ),
    );
  }
}
