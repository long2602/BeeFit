import 'package:beefit/constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/AppMethods.dart';
import '../../models/databaseHelper.dart';
import '../../models/exercise.dart';
import '../Exercise/DetailExerciseScreen.dart';

class ResultFilterScreen extends StatefulWidget {
  final List<int> _categories, _types, _levels;
  const ResultFilterScreen(
      {required List<int> categories,
      required List<int> types,
      required List<int> levels,
      Key? key})
      : _categories = categories,
        _levels = levels,
        _types = types,
        super(key: key);

  @override
  State<ResultFilterScreen> createState() => _ResultFilterScreenState();
}

class _ResultFilterScreenState extends State<ResultFilterScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Exercise> lists = [];
  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 30,
        backgroundColor: AppStyle.whiteColor,
        title: Text(
          'Result',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppStyle.secondaryColor,
            fontSize: 24 * _scaleFont,
          ),
        ),
        leading: const BackButton(
          color: AppStyle.secondaryColor,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: FutureBuilder(
            future: databaseHelper.filterExercise(
                widget._categories, widget._levels, widget._types),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  lists = snapshot.data as List<Exercise>;
                  return ListView.builder(
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = lists[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailExerciseScreen(
                                  exercise: exercise,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          "10 min",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          "100 kcal",
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
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
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
          )),
    );
  }
}
