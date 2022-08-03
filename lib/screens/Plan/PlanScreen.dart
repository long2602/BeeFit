import 'package:beefit/models/challenge.dart';
import 'package:beefit/models/plan.dart';
import 'package:beefit/screens/Plan/DetailChallengeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../SearchScreen/SearchFoodScreen.dart';
import 'DetailPlanScreen.dart';

class PlanScreen extends StatefulWidget {
  final User _user;
  const PlanScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<Plan> listPlanSuggested = [];
    List<Challenge> listChallenges = [];

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
          child: FutureBuilder(
            future: Future.wait([
              databaseHelper.getPlan(),
              databaseHelper.getPlanById(2),
              databaseHelper.getChallenges(),
            ]),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              listPlanSuggested = snapshot.data![0] as List<Plan>;
              Plan personalPlan = snapshot.data![1] as Plan;
              listChallenges = snapshot.data![2] as List<Challenge>;
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12 * _scaleScreen),
                    padding: EdgeInsets.symmetric(
                        vertical: 16 * _scaleScreen,
                        horizontal: 16 * _scaleScreen),
                    decoration: BoxDecoration(
                      borderRadius: AppStyle.appBorder,
                      color: AppStyle.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppStyle.gray5Color.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Plan',
                          style: GoogleFonts.poppins(
                            color: AppStyle.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * _scaleFont,
                          ),
                        ),
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: AppStyle.appBorder,
                            child: Image.asset(
                              "assets/imgs/${personalPlan.img}.png",
                              height: 60 * _scaleScreen,
                              width: 60 * _scaleScreen,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            personalPlan.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: AppStyle.secondaryColor),
                          ),
                          subtitle: Text(EnumBodyPart
                              .values[personalPlan.idBodyPart].name),
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
                                  builder: (context) => DetailPlanScreen(
                                        plan: personalPlan,
                                        user: widget._user,
                                      )),
                            );
                          },
                        ),
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: AppStyle.appBorder,
                            child: Image.asset(
                              "assets/imgs/dinner.png",
                              height: 60 * _scaleScreen,
                              width: 60 * _scaleScreen,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            'Food',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: AppStyle.secondaryColor),
                          ),
                          subtitle: Text('3 Meal'),
                          contentPadding: EdgeInsets.zero,
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                          calo: widget._user.bmr!
                                              .ceil()
                                              .toDouble(),
                                        )),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppStyle.primaryColor,
                              size: 30 * _scaleScreen,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12 * _scaleScreen),
                    padding: EdgeInsets.symmetric(
                        vertical: 16 * _scaleScreen,
                        horizontal: 16 * _scaleScreen),
                    decoration: BoxDecoration(
                      borderRadius: AppStyle.appBorder,
                      color: AppStyle.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppStyle.gray5Color.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suggested',
                          style: GoogleFonts.poppins(
                            color: AppStyle.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * _scaleFont,
                          ),
                        ),
                        for (Plan item in listPlanSuggested)
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: AppStyle.appBorder,
                              child: Image.asset(
                                "assets/imgs/${item.img}.png",
                                height: 60 * _scaleScreen,
                                width: 60 * _scaleScreen,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.secondaryColor),
                            ),
                            subtitle: Text(
                                EnumBodyPart.values[item.idBodyPart - 1].name),
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
                                    builder: (context) => DetailPlanScreen(
                                          plan: item,
                                          user: widget._user,
                                        )),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12 * _scaleScreen),
                    padding: EdgeInsets.symmetric(
                        vertical: 16 * _scaleScreen,
                        horizontal: 16 * _scaleScreen),
                    decoration: BoxDecoration(
                      borderRadius: AppStyle.appBorder,
                      color: AppStyle.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppStyle.gray5Color.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Challenges',
                          style: GoogleFonts.poppins(
                            color: AppStyle.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * _scaleFont,
                          ),
                        ),
                        for (Challenge item in listChallenges)
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: AppStyle.appBorder,
                              child: Image.asset(
                                "assets/imgs/${item.image}.png",
                                height: 60 * _scaleScreen,
                                width: 60 * _scaleScreen,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.secondaryColor),
                            ),
                            subtitle: Text(
                                EnumBodyPart.values[item.bodyPartId - 1].name),
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
                                    builder: (context) => DetailChallengeScreen(
                                          challenge: item,
                                          user: widget._user,
                                        )),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
