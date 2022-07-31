import 'dart:async';
import 'package:get/get.dart';

class CountDownTimerState extends GetxController {
  var max = 30, count = 30;
  bool isStart = false, isPause = false, isReset = false, isFinish = false;
  late Timer _timer;

  void stateTimerStart() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
        isPause = false;
        isStart = true;
        isReset = false;
        update();
      } else {
        isFinish = true;
        _timer.cancel();
      }
    });
  }

  // user can set count down seconds, from TextField
  void setNumber(var number) {
    count = int.parse(number);
    update();
  }

  // pause the timer
  void pause() {
    _timer.cancel();
    isPause = true;
    isStart = false;
    isReset = false;
    update();
  }

  // reset count value to 10
  void reset() {
    _timer.cancel();
    isPause = false;
    isStart = false;
    isReset = true;
    count = 30;
    update();
  }
}
