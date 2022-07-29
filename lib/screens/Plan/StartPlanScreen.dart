import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/Plan/PauseScreen.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:beefit/widgets/CountDownTimerState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../widgets/TimeLine.dart';
import 'package:video_player/video_player.dart';

class StartPlan extends StatefulWidget {
  const StartPlan({Key? key}) : super(key: key);
  @override
  _StartPlanState createState() => _StartPlanState();
}

class _StartPlanState extends State<StartPlan> {
  final CountDownTimerState timerState = Get.put(CountDownTimerState());
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/imgs/video/videoTest.mp4');
    _controller.addListener(() {
      setState(() {});
    });
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              child: Text(
                'Exercises 2/11',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Push up'.toUpperCase(),
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
                                builder: (context) => buildSheet()),
                            icon: Icon(
                              Icons.help_outline,
                              color: Colors.grey.shade400,
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
                                                  Get.to(PauseScreen(
                                                    time: timerState.count,
                                                  ));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.abc),
                    color: Colors.transparent,
                  ),
                  Column(
                    children: [
                      Text(
                        "NEXT",
                        style: GoogleFonts.poppins(
                            color: AppStyle.gray3Color,
                            fontWeight: FontWeight.w500,
                            fontSize: 15 * _scaleFont),
                      ),
                      Text(
                        'Exercises'.toUpperCase(),
                        style: GoogleFonts.poppins(
                            color: AppStyle.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17 * _scaleFont),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30 * _scaleScreen),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_outlined),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet() {
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
                'Push up',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Performing hot reload...Syncing files to device Android SDK built for x86...Reloaded 1 of 607 libraries in 687ms.',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
              ),
            ),
            Timeline(
              children: const <Widget>[
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 300,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
              indicators: const <Widget>[
                NodeCircle(),
                NodeCircle(),
                NodeCircle(),
                NodeCircle(),
              ],
              lineColor: AppStyle.primaryColor,
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
