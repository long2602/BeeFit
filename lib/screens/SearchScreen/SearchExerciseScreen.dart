import 'package:beefit/constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/AppMethods.dart';
import '../../models/databaseHelper.dart';
import '../../models/exercise.dart';
import '../Exercise/DetailExerciseScreen.dart';

class SearchExerciseScreen extends StatefulWidget {
  const SearchExerciseScreen({Key? key}) : super(key: key);

  @override
  State<SearchExerciseScreen> createState() => _SearchExerciseScreenState();
}

class _SearchExerciseScreenState extends State<SearchExerciseScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Exercise> lists = [];
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
            future: databaseHelper.searchExerciseByName(_keyword),
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
