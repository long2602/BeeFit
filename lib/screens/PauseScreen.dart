import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/AppMethods.dart';

class PauseScreen extends StatelessWidget {
  final int _time;
  const PauseScreen({Key? key, required int time})
      : _time = time,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      appBar: AppBar(
        backgroundColor: AppStyle.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => buildSheet()),
                icon: const Icon(Icons.list),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30 * _scaleScreen, vertical: 30 * _scaleScreen),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'REST',
                    style: GoogleFonts.poppins(
                        color: AppStyle.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30 * _scaleFont),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '00: $_time',
                    style: GoogleFonts.poppins(
                        color: AppStyle.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 60 * _scaleFont),
                    textAlign: TextAlign.center,
                  ),
                  CommonButton(
                    onPressed: () {},
                    backgroundColor: AppStyle.whiteColor,
                    text: "SKIP",
                    textColor: AppStyle.primaryColor,
                    elevation: 0,
                    width: 100 * _scaleScreen,
                    height: 40 * _scaleScreen,
                    borderRadius: 30,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next 2/11',
                  style: GoogleFonts.poppins(
                      color: AppStyle.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * _scaleFont),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Text(
                      'Push up'.toUpperCase(),
                      style: GoogleFonts.poppins(
                          color: AppStyle.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24 * _scaleFont),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help_outline,
                        color: AppStyle.whiteColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      snap: false,
      builder: (_, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 24,
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.cancel))
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                primary: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
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
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "Arm Circle".toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppStyle.secondaryColor,
                          fontSize: 18,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                    ),
                  );
                },
                itemCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
