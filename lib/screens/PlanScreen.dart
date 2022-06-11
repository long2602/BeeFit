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
      body:SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )
    );
  }
}
