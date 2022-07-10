import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyle.primaryColor,
          title: Text(
            'Add Breakfast',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: AppStyle.whiteColor,
              fontSize: 24 * _scaleFont,
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(85),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 30 * _scaleScreen, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppStyle.primaryColor2),
              child: TextField(
                style: GoogleFonts.poppins(
                    color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: AppStyle.whiteColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Search for food',
                  hintStyle: TextStyle(
                      color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'Recent'),
                Tab(text: 'My food'),
              ],
              labelStyle: GoogleFonts.poppins(
                fontSize: 14 * _scaleFont,
                fontWeight: FontWeight.w700,
              ),
              labelColor: AppStyle.secondaryColor,
              unselectedLabelColor: AppStyle.gray4Color,
              indicatorColor: AppStyle.primaryColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
