// ignore_for_file: file_names

import 'package:beefit/models/defaultReps.dart';
import 'package:beefit/screens/Exercise/DetailExerciseScreen.dart';
import 'package:beefit/screens/SearchScreen/FilterExerciseScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../../models/exercise.dart';
import '../SearchScreen/SearchExerciseScreen.dart';

class ExerciseScreen extends StatefulWidget {
  final User _user;
  const ExerciseScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DefaultTabController(
      length: 8,
      child: Scaffold(
          backgroundColor: AppStyle.whiteColor,
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 30,
            backgroundColor: AppStyle.whiteColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercise',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 24 * _scaleFont,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SearchExerciseScreen(
                                    user: widget._user,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        size: 24 * _scaleScreen,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FilterExerciseScreen(
                                    user: widget._user,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.tune,
                        size: 24 * _scaleScreen,
                        color: AppStyle.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Arm'),
                Tab(text: 'Chest'),
                Tab(text: 'Abs'),
                Tab(text: 'Butt'),
                Tab(text: 'Legs'),
                Tab(text: 'Full Body'),
                Tab(text: 'Shoulder'),
                Tab(text: 'Back'),
              ],
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              indicator: BoxDecoration(
                color: AppStyle.primaryColor,
                borderRadius: AppStyle.appBorder,
              ),
              unselectedLabelColor: AppStyle.black1Color,
              labelStyle: GoogleFonts.poppins(
                fontSize: 14 * _scaleFont,
                fontWeight: FontWeight.w500,
              ),
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              TabExercise(idPart: 1, user: widget._user),
              TabExercise(idPart: 2, user: widget._user),
              TabExercise(idPart: 3, user: widget._user),
              TabExercise(idPart: 4, user: widget._user),
              TabExercise(idPart: 5, user: widget._user),
              TabExercise(idPart: 6, user: widget._user),
              TabExercise(idPart: 7, user: widget._user),
              TabExercise(idPart: 8, user: widget._user),
            ],
          )),
    );
  }
}

class TabExercise extends StatefulWidget {
  const TabExercise({required int idPart, required User user, Key? key})
      : _idPart = idPart,
        _user = user,
        super(key: key);
  final int _idPart;
  final User _user;

  @override
  State<TabExercise> createState() => _TabExerciseState();
}

class _TabExerciseState extends State<TabExercise> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Exercise> lists = [];

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: FutureBuilder(
        future: Future.wait([
          databaseHelper.getExerciseByBodyPart(widget._idPart),
          databaseHelper.getDefaultRepByIdBodyPart(
              widget._idPart, widget._user.level!),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              lists = snapshot.data![0] as List<Exercise>;
              DefaultReps defaultReps = snapshot.data![1] as DefaultReps;
              return ListView.builder(
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  Exercise exercise = lists[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailExerciseScreen(
                              exercise: exercise,
                              defaultReps: defaultReps,
                              user: widget._user,
                            ),
                          ),
                        );
                      },
                      tileColor: AppStyle.gray5Color.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppStyle.appBorder,
                      ),
                      leading: ClipRRect(
                        borderRadius: AppStyle.appBorder,
                        child: Image.asset(
                          "assets/imgs/exercises/${exercise.gif}.jpg",
                          height: 60 * _scaleScreen,
                          width: 60 * _scaleScreen,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        exercise.name.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppStyle.secondaryColor,
                          fontSize: 18 * _scaleFont,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppStyle.whiteColor,
                                  borderRadius: AppStyle.appBorder,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: AppStyle.secondaryColor,
                                      size: 18 * _scaleFont,
                                    ),
                                    SizedBox(
                                      width: 6 * _scaleScreen,
                                    ),
                                    Text(
                                      exercise.isRepCount == 0
                                          ? "${defaultReps.duration} sec"
                                          : "x ${defaultReps.rep}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: AppStyle.secondaryColor,
                                        fontSize: 12 * _scaleFont,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12 * _scaleScreen,
                                  vertical: 4 * _scaleScreen,
                                ),
                              ),
                              SizedBox(
                                width: 10 * _scaleScreen,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppStyle.whiteColor,
                                  borderRadius: AppStyle.appBorder,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/imgs/fire.png",
                                      width: 12 * _scaleScreen,
                                      height: 12 * _scaleScreen,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10 * _scaleScreen,
                                    ),
                                    Text(
                                      "${AppMethods.calculateMet(widget._user.weight!, defaultReps.rep!, defaultReps.duration!, exercise.isRepCount!, exercise.met!).ceilToDouble()} kcal",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: AppStyle.secondaryColor,
                                        fontSize: 12 * _scaleFont,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12 * _scaleScreen,
                                  vertical: 4 * _scaleScreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 16),
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
