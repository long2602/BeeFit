import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_methods.dart';
import '../constants/app_style.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 30,
        // automaticallyImplyLeading: false,
        backgroundColor: AppStyle.whiteColor,
        title: Text(
          'Personal Plan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppStyle.secondaryColor,
            fontSize: 24 * _scaleFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 15 * _scaleScreen, vertical: 15 * _scaleScreen),
                decoration: BoxDecoration(
                  color: AppStyle.primaryColor,
                  borderRadius: AppStyle.appBorder,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Weekly Active Days",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: AppStyle.whiteColor,
                            fontSize: 14 * _scaleFont,
                          ),
                        ),
                        Text(
                          "1/4",
                          style: GoogleFonts.poppins(
                            color: AppStyle.whiteColor,
                            fontSize: 14 * _scaleFont,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10 * _scaleScreen),
                      height: 40 * _scaleScreen,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: index!=29? 8:0),
                            height: 30 * _scaleScreen,
                            width: 30 * _scaleScreen,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppStyle.whiteColor,
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: GoogleFonts.poppins(
                                  color: AppStyle.primaryColor,
                                  fontSize: 14 * _scaleFont,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
