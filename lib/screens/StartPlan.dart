import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:beefit/widgets/CountDownTimerState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../constants/AppMethods.dart';
import '../widgets/TimeLine.dart';

class StartPlan extends StatefulWidget {
  const StartPlan({Key? key}) : super(key: key);

  @override
  _StartPlanState createState() => _StartPlanState();
}

class _StartPlanState extends State<StartPlan> {
  // late VideoPlayerController controller;
  final CountDownTimerState timerState = Get.put(CountDownTimerState());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller = VideoPlayerController.network("assets/video.mp4")
    //   ..addListener(() {})
    //   ..setLooping(true)
    //   ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 8),
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(15),
                //       // child: VideoPlayer(
                //       //   controller: controller,
                //       // )),
                //       child: Image.network(
                //           'https://c.tenor.com/h9W4zejLjTMAAAAC/fit-workout.gif')),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * _scaleScreen),
                  child: Image.network(
                      'https://c.tenor.com/h9W4zejLjTMAAAAC/fit-workout.gif'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * _scaleScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Push up'.toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: AppStyle.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30 * _scaleFont,
                        ),
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
                        icon: const Icon(
                          Icons.help,
                          color: AppStyle.gray5Color,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * _scaleScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10 * _scaleScreen),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Center(
                            child: Icon(
                              Icons.navigate_before,
                              size: 50 * _scaleFont,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80 * _scaleScreen,
                        width: 80 * _scaleScreen,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            GetBuilder<CountDownTimerState>(
                              builder: (_) => CircularProgressIndicator(
                                value: timerState.count / timerState.max,
                                strokeWidth: 08,
                                color: AppStyle.secondaryColor,
                                backgroundColor: AppStyle.gray5Color,
                              ),
                            ),
                            GetBuilder<CountDownTimerState>(
                              builder: (_) => Center(
                                child: !timerState.isStart
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            timerState.stateTimerStart();
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 50 * _scaleFont,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                            shape: const CircleBorder(
                                              side: BorderSide.none,
                                            ),
                                            primary:AppStyle.primaryColor,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        '${timerState.count}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 30 * _scaleFont,
                                          fontWeight: FontWeight.bold,
                                          color: AppStyle.secondaryColor,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10 * _scaleScreen),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Center(
                            child: Icon(
                              Icons.navigate_next,
                              size: 50 * _scaleFont,
                              color: AppStyle.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         timerState.pause();
                //       },
                //       child: const Text('Pause'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         timerState.reset();
                //       },
                //       child: const Text('Reset'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.5,
      builder: (_, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          primary: false,
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
                child: Image.asset(
                    'assets/imgs/fitness1.png',
                  width: double.infinity,
                  // height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Push up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Performing hot reload...Syncing files to device Android SDK built for x86...Reloaded 1 of 607 libraries in 687ms.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
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
                  height: 100,
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
              lineColor: const Color(0xffE4A248),
            ),
            CommonButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: const Color(0xffE4A248),
              text: 'Close'.toUpperCase(),
              textColor: Colors.white,
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
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xffE4A248),
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

class VideoPlayer extends StatelessWidget {
  VideoPlayerController _controller;

  VideoPlayer({required VideoPlayerController controller, Key? key})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _controller != null && _controller.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
  }

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => VideoPlayer(controller: _controller);
}
