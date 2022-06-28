// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/AppMethods.dart';
import '../constants/AppStyles.dart';

class DetailExerciseScreen extends StatefulWidget {
  const DetailExerciseScreen({Key? key}) : super(key: key);

  @override
  State<DetailExerciseScreen> createState() => _DetailExerciseScreenState();
}

class _DetailExerciseScreenState extends State<DetailExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 30,
        automaticallyImplyLeading: false,
        backgroundColor: AppStyle.whiteColor,
        title: Text(
          'Exercise',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppStyle.secondaryColor,
            fontSize: 24 * _scaleFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              right: 30 * _scaleScreen, left: 30 * _scaleScreen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset("assets/imgs/fitness1.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Jumping Jack',
                      style: GoogleFonts.poppins(
                        fontSize: 18 * _scaleFont,
                        fontWeight: FontWeight.w600,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                    Text(
                      '10 min - 100 Calories burn',
                      style: GoogleFonts.poppins(
                        fontSize: 12 * _scaleFont,
                        fontWeight: FontWeight.w500,
                        color: AppStyle.gray3Color,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Descriptions',
                      style: GoogleFonts.poppins(
                        fontSize: 18 * _scaleFont,
                        fontWeight: FontWeight.w600,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                    Text(
                      'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide Read More...',
                      style: GoogleFonts.poppins(
                        fontSize: 12 * _scaleFont,
                        fontWeight: FontWeight.w500,
                        color: AppStyle.gray3Color,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How to do it',
                      style: GoogleFonts.poppins(
                        fontSize: 18 * _scaleFont,
                        fontWeight: FontWeight.w600,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                    Text(
                      '4 steps',
                      style: GoogleFonts.poppins(
                        fontSize: 12 * _scaleFont,
                        fontWeight: FontWeight.w500,
                        color: AppStyle.gray3Color,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index <9 ? '0${index+1}':(index+1).toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14 * _scaleFont,
                              fontWeight: FontWeight.w500,
                              color: AppStyle.primaryColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16 * _scaleScreen),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 18 * _scaleScreen,
                                  width: 18 * _scaleScreen,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    color: AppStyle.whiteColor,
                                    border: Border.all(
                                      color: AppStyle.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppStyle.primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppStyle.primaryColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ],
                              mainAxisSize: MainAxisSize.max,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spread Your Arms",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14 * _scaleFont,
                                    fontWeight: FontWeight.w500,
                                    color: AppStyle.black1Color,
                                  ),
                                ),
                                Text(
                                  "To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14 * _scaleFont,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff7B6F72),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
