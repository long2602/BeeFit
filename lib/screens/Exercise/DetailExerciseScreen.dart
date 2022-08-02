// ignore_for_file: file_names

import 'package:beefit/models/defaultReps.dart';
import 'package:beefit/models/exercise.dart';
import 'package:beefit/models/instruction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../../widgets/TimeLine.dart';
import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';

class DetailExerciseScreen extends StatefulWidget {
  final Exercise _exercise;
  final DefaultReps _defaultReps;
  final User _user;
  const DetailExerciseScreen(
      {required Exercise exercise,
      required DefaultReps defaultReps,
      required User user,
      Key? key})
      : _exercise = exercise,
        _defaultReps = defaultReps,
        _user = user,
        super(key: key);

  @override
  State<DetailExerciseScreen> createState() => _DetailExerciseScreenState();
}

class _DetailExerciseScreenState extends State<DetailExerciseScreen> {
  late Exercise exercise;
  late VideoPlayerController _controller;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Instruction> lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exercise = widget._exercise;
    _controller =
        VideoPlayerController.asset('assets/imgs/video/${exercise.gif}.mp4');
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
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
          ],
        ),
        leading: const BackButton(color: AppStyle.secondaryColor),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(right: 30 * _scaleScreen, left: 30 * _scaleScreen),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: AppStyle.appBorder,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            exercise.name,
                            style: GoogleFonts.poppins(
                              fontSize: 18 * _scaleFont,
                              fontWeight: FontWeight.w600,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
                          Text(
                            exercise.isRepCount == 0
                                ? '${widget._defaultReps.duration} sec - ${AppMethods.calculateMet(widget._user.weight!, widget._defaultReps.rep!, widget._defaultReps.duration!, exercise.isRepCount!, exercise.met!).ceilToDouble()} Calories burn'
                                : '',
                            style: GoogleFonts.poppins(
                              fontSize: 12 * _scaleFont,
                              fontWeight: FontWeight.w500,
                              color: AppStyle.gray3Color,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Descriptions',
                            style: GoogleFonts.poppins(
                              fontSize: 18 * _scaleFont,
                              fontWeight: FontWeight.w600,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
                          Text(
                            exercise.description,
                            style: GoogleFonts.poppins(
                              fontSize: 12 * _scaleFont,
                              fontWeight: FontWeight.w500,
                              color: AppStyle.gray3Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: databaseHelper
                          .getInstructionsByIdExercise(exercise.id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            lists = snapshot.data as List<Instruction>;
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'How to do it',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18 * _scaleFont,
                                          fontWeight: FontWeight.w600,
                                          color: AppStyle.secondaryColor,
                                        ),
                                      ),
                                      Text(
                                        '${lists.length} steps',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12 * _scaleFont,
                                          fontWeight: FontWeight.w500,
                                          color: AppStyle.gray3Color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Timeline(
                                  children: <Widget>[
                                    for (Instruction item in lists)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Step ${item.step}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14 * _scaleFont,
                                              fontWeight: FontWeight.w500,
                                              color: AppStyle.black1Color,
                                            ),
                                          ),
                                          Text(
                                            item.detail,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14 * _scaleFont,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff7B6F72),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                  indicators: <Widget>[
                                    for (Instruction item in lists)
                                      const NodeCircle(),
                                  ],
                                  lineColor: AppStyle.primaryColor,
                                ),
                              ],
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Text('no data');
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NodeCircle extends StatelessWidget {
  const NodeCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          color: AppStyle.whiteColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppStyle.primaryColor,
            width: 1,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xffE9A24A), Color(0xffF2BE6A), Color(0xffF6D08B)],
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
            ),
          ),
        ),
      ),
    );
  }
}
