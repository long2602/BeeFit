import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/PlamExerciseDetail.dart';
import 'package:beefit/models/exercise.dart';
import 'package:beefit/screens/Plan/PauseScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:beefit/widgets/CountDownTimerState.dart';
import 'package:beefit/widgets/TimeLine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../models/databaseHelper.dart';
import 'package:video_player/video_player.dart';

import '../../models/instruction.dart';

class StartPlanScreen extends StatefulWidget {
  final List<PlanExerciseDetail> _list;
  const StartPlanScreen({required List<PlanExerciseDetail> list, Key? key})
      : _list = list,
        super(key: key);
  @override
  _StartPlanScreenState createState() => _StartPlanScreenState();
}

class _StartPlanScreenState extends State<StartPlanScreen> {
  final CountDownTimerState timerState = Get.put(CountDownTimerState());
  late VideoPlayerController _controller;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  late List<PlanExerciseDetail> _list = widget._list;
  final PageController _pageController = PageController(initialPage: 0);
  int indexPage = 0;
  late String videoName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoName = _list[0].gif;
    _controller =
        VideoPlayerController.asset('assets/imgs/video/$videoName.mp4');
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    timerState.setNumber(_list[0].duration.toString());
    timerState.setMaxNumber(_list[0].duration.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Future<void> _confirmDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context1) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 0,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 22),
                child: Text(
                  "Deleting this wallet will also, delete all transactions under this wallet. Deleted data cannot be recovered. Are you sure you want to proceed?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: AppStyle.appBorder,
                        child: MaterialButton(
                          minWidth: double.infinity,
                          color: AppStyle.gray5Color,
                          elevation: 0,
                          onPressed: () => Navigator.pop(context1),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppStyle.gray1Color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: AppStyle.appBorder,
                        child: MaterialButton(
                          minWidth: double.infinity,
                          color: AppStyle.primaryColor,
                          elevation: 0,
                          onPressed: () {
                            int count = 0;
                            Navigator.popUntil(
                              context,
                              (route) {
                                return count++ == 2;
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppStyle.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: AppStyle.appBorder),
      ),
      barrierDismissible: false,
    );
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
        leading: const BackButton(
          color: AppStyle.secondaryColor,
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              child: Text(
                'Exercises ${indexPage + 1} /${_list.length}',
                style: GoogleFonts.poppins(
                    color: AppStyle.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20 * _scaleFont),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<CountDownTimerState>(
        builder: (_) {
          if (timerState.isFinish == true) {
            if (indexPage == _list.length - 1) {
              Future.delayed(Duration.zero, () => _confirmDialog(context));
            } else {
              timerState.isFinish = false;
              Future.delayed(
                  Duration.zero,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PauseScreen(
                            list: _list,
                            item: _list[indexPage],
                            index: indexPage + 1,
                          ),
                        ),
                      ));
              timerState.setNumber(_list[indexPage].duration.toString());
              timerState.setMaxNumber(_list[indexPage].duration.toString());

              _pageController.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
            }
            // Future.delayed(Duration.zero,
            //     () => _showMyDialog(_list[indexPage].restDuration!));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  indexPage = index;
                  timerState.isFinish = false;
                  timerState.isStart = false;
                  timerState.isPause = false;
                  timerState.isReset = false;
                  videoName = _list[indexPage].gif;
                  _controller = VideoPlayerController.asset(
                      'assets/imgs/video/$videoName.mp4');
                  _controller.initialize().then((_) => setState(() {}));
                  _controller.setLooping(true);
                  _controller.play();
                });
              },
              children: [
                for (int i = 0; i < _list.length; i++)
                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: AppStyle.appBorder,
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    _list[i].name,
                                    style: GoogleFonts.poppins(
                                        color: AppStyle.secondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25 * _scaleFont),
                                  ),
                                  IconButton(
                                    onPressed: () => showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) => buildSheet(
                                        Exercise(
                                            name: _list[i].name,
                                            description: _list[i].description,
                                            gif: _list[i].gif,
                                            level: _list[i].level,
                                            type: _list[i].type,
                                            met: _list[i].met,
                                            restDuration: _list[i].duration,
                                            id: _list[i].id,
                                            isRepCount: _list[i].isRepCount),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.help_outline,
                                      color: AppStyle.gray3Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _list[i].isRepCount == 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * _scaleScreen),
                                    child: Text(
                                      '00:${timerState.count}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: AppStyle.primaryColor,
                                        fontSize: 50 * _scaleFont,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * _scaleScreen),
                                    child: Text(
                                      'x ${_list[i].rep}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: AppStyle.primaryColor,
                                        fontSize: 50 * _scaleFont,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Material(
                                      color: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        onTap: () {
                                          _pageController.previousPage(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeInOut);
                                        },
                                        child: const Icon(
                                          Icons.arrow_left_rounded,
                                          size: 80,
                                          color: AppStyle.gray4Color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  _list[i].isRepCount == 0
                                      ? Container(
                                          height: 80 * _scaleScreen,
                                          width: 80 * _scaleScreen,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20 * _scaleScreen),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              CircularProgressIndicator(
                                                value: timerState.count /
                                                    timerState.max,
                                                strokeWidth: 08,
                                                color: const Color(0xffF6D08B),
                                                backgroundColor:
                                                    const Color(0xffEDEDED),
                                              ),
                                              Center(
                                                  child: !timerState.isStart
                                                      ? SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              timerState
                                                                  .stateTimerStart();
                                                            },
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                size: 40,
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              elevation: 0,
                                                              shape:
                                                                  const CircleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                              ),
                                                              primary: AppStyle
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              if (timerState
                                                                          .isStart ==
                                                                      true &&
                                                                  timerState
                                                                          .isPause ==
                                                                      false) {
                                                                timerState
                                                                    .pause();
                                                              } else {
                                                                timerState
                                                                    .stateTimerStart();
                                                              }
                                                            },
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.pause,
                                                                size: 40,
                                                                color: AppStyle
                                                                    .secondaryColor,
                                                              ),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              elevation: 0,
                                                              shape:
                                                                  const CircleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                              ),
                                                              primary: Colors
                                                                  .transparent,
                                                            ),
                                                          ),
                                                        ))
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 80 * _scaleScreen,
                                          width: 80 * _scaleScreen,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20 * _scaleScreen),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              CircularProgressIndicator(
                                                value: timerState.count /
                                                    timerState.max,
                                                strokeWidth: 08,
                                                color: const Color(0xffF6D08B),
                                                backgroundColor:
                                                    const Color(0xffEDEDED),
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Future.delayed(
                                                          Duration.zero,
                                                          () => Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      PauseScreen(
                                                                    list: _list,
                                                                    item: _list[
                                                                        indexPage],
                                                                    index:
                                                                        indexPage +
                                                                            1,
                                                                  ),
                                                                ),
                                                              ));
                                                      timerState.setNumber(
                                                          _list[indexPage]
                                                              .duration
                                                              .toString());
                                                      timerState.setMaxNumber(
                                                          _list[indexPage]
                                                              .duration
                                                              .toString());
                                                      _pageController.nextPage(
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                    },
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 40,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      elevation: 0,
                                                      shape: const CircleBorder(
                                                        side: BorderSide.none,
                                                      ),
                                                      primary:
                                                          AppStyle.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Material(
                                      color: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        onTap: () {
                                          if (_list[i].isRepCount != 0) {
                                            Get.snackbar(
                                              "Can not skip exercise!",
                                              "You need to press button check to practice next exercise.",
                                            );
                                          } else {
                                            if (!timerState.isFinish) {
                                              timerState.pause();
                                              Get.snackbar(
                                                "Can not skip exercise!",
                                                "You need to complete all exercises to get better result.",
                                              );
                                            } else {
                                              timerState.setNumber(
                                                  _list[indexPage]
                                                      .duration
                                                      .toString());
                                              timerState.setMaxNumber(
                                                  _list[indexPage]
                                                      .duration
                                                      .toString());
                                              _pageController.nextPage(
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  curve: Curves.easeInOut);
                                            }
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_right_rounded,
                                          size: 80,
                                          color: AppStyle.gray4Color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            (indexPage + 1) != _list.length
                                ? "NEXT"
                                : "PREVIOUS",
                            style: GoogleFonts.poppins(
                                color: AppStyle.gray3Color,
                                fontWeight: FontWeight.w500,
                                fontSize: 15 * _scaleFont),
                          ),
                          Text(
                            (indexPage + 1) != _list.length
                                ? _list[indexPage + 1].name.toUpperCase()
                                : _list[indexPage - 1].name.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: AppStyle.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17 * _scaleFont),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30 * _scaleScreen),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSheet(Exercise exercise) {
    List<Instruction> lists = [];
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (_, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: ListView(
          primary: false,
          shrinkWrap: true,
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 80,
                height: 4,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: AppStyle.appBorder,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                exercise.name,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                exercise.description,
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
              ),
            ),
            FutureBuilder(
              future: databaseHelper.getInstructionsByIdExercise(exercise.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    lists = snapshot.data as List<Instruction>;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              ),
                          ],
                          indicators: <Widget>[
                            for (Instruction item in lists) const NodeCircle(),
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
            const SizedBox(
              height: 20,
            ),
            CommonButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: AppStyle.primaryColor,
              text: 'Close'.toUpperCase(),
              textColor: AppStyle.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(int _time) async {
    final CountDownTimerState _timerState = Get.put(CountDownTimerState());
    _timerState.setNumber(_time);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return GetBuilder<CountDownTimerState>(
          builder: (_) {
            if (_timerState.isFinish == true) {
              _timerState.setNumber(_list[indexPage].duration.toString());
              _timerState.setMaxNumber(_list[indexPage].duration.toString());
              _pageController.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
              Navigator.pop(context);
            } else if (_timerState.isStart == true) {
              // _timerState.setNumber(_time.toString());
              _timerState.stateTimerStart();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'REST',
                  style: GoogleFonts.poppins(
                      color: AppStyle.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '00:${_timerState.count}',
                  style: GoogleFonts.poppins(
                      color: AppStyle.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 60),
                  textAlign: TextAlign.center,
                ),
                CommonButton(
                  onPressed: () {
                    Navigator.pop(context);
                    timerState.setNumber(_list[indexPage].duration.toString());
                    timerState
                        .setMaxNumber(_list[indexPage].duration.toString());
                    _pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                  },
                  backgroundColor: AppStyle.whiteColor,
                  text: "SKIP",
                  textColor: AppStyle.primaryColor,
                  elevation: 0,
                  width: 100,
                  height: 40,
                  borderRadius: 30,
                ),
              ],
            );
          },
        );
      },
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
