import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/exercise.dart';
import 'package:beefit/screens/Plan/PauseScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:beefit/widgets/CountDownTimerState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../models/databaseHelper.dart';
import '../../models/instruction.dart';
import '../../widgets/TimeLine.dart';
import 'package:video_player/video_player.dart';

class StartExerciseScreen extends StatefulWidget {
  final Exercise _exercise;
  const StartExerciseScreen({Key? key, required Exercise exercise})
      : _exercise = exercise,
        super(key: key);
  @override
  _StartExerciseScreenState createState() => _StartExerciseScreenState();
}

class _StartExerciseScreenState extends State<StartExerciseScreen> {
  final CountDownTimerState timerState = Get.put(CountDownTimerState());
  late VideoPlayerController _controller;
  late Exercise exercise;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
      ),
      body: GetBuilder<CountDownTimerState>(
        builder: (_) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
          child: Column(
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
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            exercise.name.toUpperCase(),
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
                                builder: (context) => buildSheet(exercise)),
                            icon: const Icon(
                              Icons.help_outline,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10 * _scaleScreen),
                      child: Text(
                        '00:${timerState.count}',
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Material(
                              color: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_left_rounded,
                                  size: 80,
                                  color: AppStyle.gray4Color,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 80 * _scaleScreen,
                            width: 80 * _scaleScreen,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20 * _scaleScreen),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: timerState.count / timerState.max,
                                  strokeWidth: 08,
                                  color: const Color(0xffF6D08B),
                                  backgroundColor: const Color(0xffEDEDED),
                                ),
                                Center(
                                    child: !timerState.isStart
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                timerState.stateTimerStart();
                                              },
                                              child: const Center(
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  size: 40,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                elevation: 0,
                                                shape: const CircleBorder(
                                                  side: BorderSide.none,
                                                ),
                                                primary: AppStyle.primaryColor,
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (timerState.isStart ==
                                                        true &&
                                                    timerState.isPause ==
                                                        false) {
                                                  timerState.pause();
                                                } else {
                                                  timerState.stateTimerStart();
                                                }
                                              },
                                              child: const Center(
                                                child: Icon(
                                                  Icons.pause,
                                                  size: 40,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                elevation: 0,
                                                shape: const CircleBorder(
                                                  side: BorderSide.none,
                                                ),
                                                primary: Colors.transparent,
                                              ),
                                            ),
                                          ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Material(
                              color: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                onTap: () {},
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
            ],
          ),
        ),
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
                        _ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            backgroundColor: Colors.transparent,
                            playedColor: Colors.transparent,
                            bufferedColor: Colors.transparent,
                          ),
                        ),
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

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
