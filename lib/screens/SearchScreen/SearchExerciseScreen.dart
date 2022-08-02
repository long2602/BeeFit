import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/defaultReps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/AppMethods.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../../models/exercise.dart';
import '../Exercise/DetailExerciseScreen.dart';

class SearchExerciseScreen extends StatefulWidget {
  final User _user;
  const SearchExerciseScreen({required User user, Key? key})
      : _user = user,
        super(key: key);
  @override
  State<SearchExerciseScreen> createState() => _SearchExerciseScreenState();
}

class _SearchExerciseScreenState extends State<SearchExerciseScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Exercise> lists = [];
  List<DefaultReps> defaults = [];
  String _keyword = "";
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.primaryColor,
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _keyword = value;
            });
          },
          style: GoogleFonts.poppins(
              color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: AppStyle.whiteColor,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Search for exercises...',
            hintStyle: TextStyle(
                color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: FutureBuilder(
            future: Future.wait([
              databaseHelper.searchExerciseByName(_keyword),
              databaseHelper.getDefaultRepByLevel(widget._user.level!),
            ]),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  lists = snapshot.data![0] as List<Exercise>;
                  defaults = snapshot.data![1] as List<DefaultReps>;
                  List<DefaultReps> defaultReps = defaults
                      .where(
                          (element) => element.idBodyPart == widget._user.level)
                      .toList();
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
                                  defaultReps: defaultReps[0],
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
                                          exercise.isRepCount == 0
                                              ? "${defaultReps[0].duration} sec"
                                              : "x ${defaultReps[0].rep}",
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
                                          "${AppMethods.calculateMet(widget._user.weight!, defaultReps[0].rep!, defaultReps[0].duration!, exercise.isRepCount!, exercise.met!).ceilToDouble()} kcal",
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
          )),
    );
  }
}
