import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AudioOrMessageSendButton extends StatefulWidget {
  @override
  State<AudioOrMessageSendButton> createState() =>
      _AudioOrMessageSendButtonState();
}

class _AudioOrMessageSendButtonState extends State<AudioOrMessageSendButton>
    with SingleTickerProviderStateMixin {
  final MessageController controller = Get.put(MessageController());

  bool _isListening = false;
  double scale = 1;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 50),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
  }

  String? _text;
  late stt.SpeechToText _speech;

  void _send() async {
    FocusScope.of(context).unfocus();
    controller.loader.value = true;
    controller.update();

    await Future.delayed(const Duration(seconds: 5));

    controller.loader.value = false;
    controller.update();

    if (controller.senderMesaage.text.isNotEmpty) {
      controller.messages.add({
        'type': ['text'],
        'content': [controller.senderMesaage.text],
      });

      controller.update();

      controller.senderMesaage.clear();
      controller.textLength.value = 0;

      controller.update();
      controller.scrollController.animateTo(
        controller.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 900),
        curve: Curves.linear,
      );
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(onStatus: (val) {
        if (val == 'done') {
          setState(() {
            _isListening = false;
          });
        }
      }, onError: (val) {
        setState(() {
          _isListening = false;
        });
      });
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            controller.senderMesaage.text += _text!;
            controller.textLength.value = controller.senderMesaage.text.length;
          }),
          listenFor: const Duration(hours: 1),
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        controller.buttonLongPress.value = true;
        setState(() {
          scale = 2;
        });
      },
      onLongPressUp: () async {
        controller.buttonLongPressup.value = true;

        controller.textLength.value = 1;
        controller.update();

        await Future.delayed(const Duration(seconds: 3));
        controller.buttonLongPressup.value = false;

        controller.textLength.value = 0;
        controller.update();
      },
      onLongPressMoveUpdate: (details) {},
      onTapUp: (details) {
        setState(() {
          scale = 2;
        });
      },
      onLongPressEnd: (details) {
        controller.buttonLongPressup.value = false;
        controller.update();

        controller.buttonLongPress.value = false;
        setState(() {
          scale = 1;
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          decoration: const ShapeDecoration(
            color: Color(0xFF128C7E),
            shape: CircleBorder(),
          ),
          alignment: Alignment.center,
          height: 50,
          width: 50,
          child: Obx(() {
            return IconButton(
              iconSize: 20,
              onPressed: () {
                controller.textLength.value == 0 ? _listen() : _send();
              },
              icon: Icon(
                color: Colors.white,
                controller.textLength.value == 0 ? Icons.mic : Icons.send,
              ),
            );
          }),
        ),
      ),
    );
  }
}
