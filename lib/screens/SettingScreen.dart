import 'package:beefit/constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/AppMethods.dart';
import '../models/User.dart';

class SettingScreen extends StatefulWidget {
  final User _user;
  const SettingScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    late User _user = widget._user;
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
        titleSpacing: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Account',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: AppStyle.secondaryColor,
                fontSize: 24 * _scaleFont,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Text(_user.name!),
        ],
      ),
    );
  }
}
