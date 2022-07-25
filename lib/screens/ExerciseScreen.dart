// ignore_for_file: file_names

import 'package:beefit/screens/DetailExerciseScreen.dart';
import 'package:beefit/screens/GetStartedScreen.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:beefit/widgets/CommonButton.dart';
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
                    // return InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => const DetailExerciseScreen()),
                    //     );
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(vertical: 4),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 6, horizontal: 12),
                    //     decoration: BoxDecoration(
                    //       borderRadius: AppStyle.appBorder,
                    //       color: AppStyle.gray5Color,
                    //     ),
                    //     child: Row(
                    //       children: [],
                    //     ),
                    //   ),
                    // );
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                      child: ListTile(
                        onTap: () {},
                        tileColor: AppStyle.gray5Color.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppStyle.appBorder,
                        ),
                        leading: ClipRRect(
                          borderRadius: AppStyle.appBorder,
                          child: Image.asset(
                            "assets/imgs/fitness1.png",
                            height: 60 * _scaleScreen,
                            width: 60 * _scaleScreen,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          "Arm Circle".toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: AppStyle.secondaryColor,
                            fontSize: 18 * _scaleFont,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppStyle.whiteColor,
                                    borderRadius: AppStyle.appBorder,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        color: AppStyle.secondaryColor,
                                        size: 18 * _scaleFont,
                                      ),
                                      SizedBox(
                                        width: 6 * _scaleScreen,
                                      ),
                                      Text(
                                        "10 min",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: AppStyle.secondaryColor,
                                          fontSize: 12 * _scaleFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12 * _scaleScreen,
                                    vertical: 4 * _scaleScreen,
                                  ),
                                ),
                                SizedBox(
                                  width: 10 * _scaleScreen,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppStyle.whiteColor,
                                    borderRadius: AppStyle.appBorder,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/imgs/fire.png",
                                        width: 12 * _scaleScreen,
                                        height: 12 * _scaleScreen,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 10 * _scaleScreen,
                                      ),
                                      Text(
                                        "100 kcal",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: AppStyle.secondaryColor,
                                          fontSize: 12 * _scaleFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12 * _scaleScreen,
                                    vertical: 4 * _scaleScreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 16),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: AppStyle.secondaryColor,
                          ),
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
