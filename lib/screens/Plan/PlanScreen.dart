import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';
import 'DetailPlanScreen.dart';
import 'ProcessPlanScreen.dart';

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
        backgroundColor: AppStyle.whiteColor,
        titleSpacing: 30,
        title: Text(
          'Personal Plan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppStyle.secondaryColor,
            fontSize: 20 * _scaleFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30 * _scaleScreen, vertical: 20 * _scaleScreen),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: AppStyle.appBorder,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffE9A24A),
                      Color(0xffF2BE6A),
                      Color(0xffF6D08B)
                    ],
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weekly active days',
                          style: GoogleFonts.poppins(
                            color: AppStyle.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * _scaleFont,
                          ),
                        ),
                        Text(
                          '1/4',
                          style: GoogleFonts.poppins(
                            color: AppStyle.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16 * _scaleFont,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12 * _scaleScreen),
                padding: EdgeInsets.symmetric(
                    vertical: 16 * _scaleScreen, horizontal: 16 * _scaleScreen),
                decoration: BoxDecoration(
                  borderRadius: AppStyle.appBorder,
                  color: AppStyle.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppStyle.gray5Color.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent',
                      style: GoogleFonts.poppins(
                        color: AppStyle.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * _scaleFont,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/imgs/fitness1.png",
                        height: 50 * _scaleScreen,
                        width: 50 * _scaleScreen,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        'Massive Upper Body',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppStyle.secondaryColor),
                      ),
                      subtitle: Text('27 days left'),
                      contentPadding: EdgeInsets.zero,
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward,
                          color: AppStyle.primaryColor,
                          size: 30 * _scaleScreen,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailPlanScreen()),
                        );
                      },
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
