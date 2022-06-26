import 'package:beefit/screens/DetailExerciseScreen.dart';
import 'package:beefit/screens/GetStartedScreen.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/AppMethods.dart';
import '../constants/AppStyles.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DefaultTabController(
      length: 5,
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
                  'Exercise',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 24 * _scaleFont,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 24 * _scaleScreen,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tune,
                        size: 24 * _scaleScreen,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Arm'),
                Tab(text: 'Chest'),
                Tab(text: 'Abs'),
                Tab(text: 'Legs'),
                Tab(text: 'Full Body'),
              ],
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              indicator: BoxDecoration(
                color: AppStyle.primaryColor,
                borderRadius: AppStyle.appBorder,
              ),
              unselectedLabelColor: AppStyle.black1Color,
              labelStyle: GoogleFonts.poppins(
                fontSize: 14 * _scaleFont,
                fontWeight: FontWeight.w500,
              ),
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    30 * _scaleScreen, 20 * _scaleScreen, 30 * _scaleScreen, 0),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (_) =>
                        //           const DetailExerciseScreen()),
                        // );
                        Get.to(const DetailExerciseScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: AppStyle.appBorder,
                          color: AppStyle.primaryColor,
                        ),
                        child: Row(
                          children: [
                            
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
