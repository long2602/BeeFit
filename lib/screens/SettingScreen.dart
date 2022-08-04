import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/GetStarted/GetStartedScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
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
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 30 * _scaleScreen, vertical: 30 * _scaleScreen),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/imgs/BEEFIT.png"),
                  radius: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome, my friend',
                    style: GoogleFonts.poppins(
                      color: AppStyle.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24 * _scaleScreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: AppStyle.appBorder,
                    color: AppStyle.gray5Color,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Gender',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget._user.gender! ? "Male" : "Female",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                      const Divider(color: AppStyle.black2Color, height: 1),
                      ListTile(
                        title: Text(
                          'Weight',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget._user.weight.toString() + " kg",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                      const Divider(color: AppStyle.black2Color, height: 1),
                      ListTile(
                        title: Text(
                          'Height',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget._user.height.toString() + " cm",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                      const Divider(color: AppStyle.black2Color, height: 1),
                      ListTile(
                        title: Text(
                          'Age',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget._user.age.toString(),
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CommonButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const GetStartedScreen(isModify: true),
                        ),
                      );
                    },
                    backgroundColor: AppStyle.primaryColor,
                    text: "Modify".toUpperCase(),
                    textColor: AppStyle.whiteColor,
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
