import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class MessageController extends GetxController {
  var messages = <Map<String, List<String>>>[].obs;
  TextEditingController senderMesaage = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxBool loader = false.obs;
  var speech = SpeechToText();
  RxBool buttonLongPress = false.obs;
  RxBool buttonLongPressup = false.obs;

  var textLength = 0.obs;
  RxDouble sendiconhorizentalheight = 150.0.obs;
  RxDouble sendiconhorizentalwidth = 60.0.obs;
  RxDouble positioned = 60.0.obs;
  RxDouble widthVertical = 70.0.obs;

  Timer? _timer;

  RxInt millisecond = 0.obs;

  void onTimerStart() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      millisecond.value += 1;
    });
  }

  void ontimerStop() {
    if (_timer != null) {
      _timer!.cancel();
      millisecond.value = 0;
    }
  }

  String formatedTime(int milliseconds) {
    int totalSeconds = milliseconds;

    int minutes = (totalSeconds / 60).truncate();
    int displaySeconds = totalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${displaySeconds.toString().padLeft(2, '0')}';
  }
}
