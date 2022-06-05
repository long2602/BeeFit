import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_methods.dart';
import '../constants/app_style.dart';

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
            actions: [
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
            title: Text(
              'Exercise',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: AppStyle.secondaryColor,
                fontSize: 24 * _scaleFont,
              ),
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
              labelStyle: GoogleFonts.poppins(fontSize: 12 * _scaleFont, fontWeight: FontWeight.w500,),
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              Container(),
              Container(),
              Container(),
              Container(),
            ],
          )),
    );
  }
}
