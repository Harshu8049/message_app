import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import 'package:speech_to_text/speech_to_text.dart';

class MessageController extends GetxController {
  var messages = <Map<String, List<String>>>[].obs;
  TextEditingController senderMesaage = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxBool loader = false.obs;
  var speech = SpeechToText();

  var textLength = 0.obs;

  void listen(bool isListen, String text) async {
    if (!isListen) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('onStatus : $status');
        },
        onError: (errorNotification) {
          print('onError: $errorNotification');
        },
      );
      if (available) {
        isListen = true;
        speech.listen(
          onResult: (result) {
            text = result.recognizedWords;
          },
        );
      } else {
        isListen = false;
        speech.stop();
      }
    }
  }
}
