import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StartPlan extends StatefulWidget {
  const StartPlan({Key? key}) : super(key: key);

  @override
  _StartPlanState createState() => _StartPlanState();
}

class _StartPlanState extends State<StartPlan> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network("assets/video.mp4")
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayer(
                      controller: controller,
                    )),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide.none,
                  ),
                  primary: const Color(0xffE4A248),
                ),
              ),
            ],
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
