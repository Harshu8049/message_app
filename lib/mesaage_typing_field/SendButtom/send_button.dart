import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AudioOrMessageSendButton extends StatefulWidget {
  const AudioOrMessageSendButton({super.key});
  @override
  State<AudioOrMessageSendButton> createState() =>
      _AudioOrMessageSendButtonState();
}

class _AudioOrMessageSendButtonState extends State<AudioOrMessageSendButton>
    with SingleTickerProviderStateMixin {
  final MessageController controller = Get.put(MessageController());

  bool _isListening = false;
  double scale = 1;
  Offset _pointer = const Offset(360, 10);

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _updatePointer(Offset offset) {
    setState(() {
      _pointer = offset;
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

  void _resetPosition() {
    controller.buttonLongPress.value = false;
    controller.update();
    setState(() {
      scale = 1; 
      _pointer =
          const Offset(360, 10); 
    });
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
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Positioned(
          left: _pointer.dx,
          bottom: _pointer.dy,
          child: GestureDetector(
            onTapDown: (details) {
              controller.onTimerStart();
              controller.update();
              controller.buttonLongPress.value = true;
              setState(() {
                scale = 1.5; 
              });
            },
            onTapUp: (details) {
              controller.onTimerStart();
              controller.update();
              controller.buttonLongPress.value = true;
              setState(() {
                scale = 1; 
              });
            },
            onTapCancel: () {
              controller.buttonLongPress.value = false;
              setState(() {
                scale = 1; 
              });
            },
            onVerticalDragStart: (details) {
              setState(() {
                scale = 2; 
              });
              controller.buttonLongPress.value = true;
            },
            onVerticalDragUpdate: (details) {
              if (_pointer.dy <= 100 && _pointer.dy >= 10) {
                _updatePointer(_pointer - Offset(0, details.delta.dy));

                setState(() {
                  scale = 1 - (_pointer.dy / 500);
                  controller.sendiconhorizentalheight.value =
                      150 - (_pointer.dy);
                  controller.positioned.value = 60 + (_pointer.dy + 20);
                });

                if (_pointer.dy >= 90) {
                  controller.buttonLongPressup.value = true;
                  controller.update();
                }

                controller.update();
              }
            },
            onVerticalDragEnd: (details) {
              _resetPosition();
              controller.sendiconhorizentalheight.value = 150;
              controller.positioned.value = 60;

              controller.update();
            },
            onHorizontalDragStart: (details) {
              setState(() {
                scale = 2; // Increase the scale on drag start
              });
              controller.buttonLongPress.value = true;
              controller.update();
            },
            onHorizontalDragUpdate: (details) {
              controller.buttonLongPressup.value = false;
              controller.update();
              if (_pointer.dx >= 180 && _pointer.dx <= 360) {
                _updatePointer(_pointer + Offset(details.delta.dx, 0));

                setState(() {
                  controller.widthVertical.value =
                      70 - (details.localPosition.dx + 50);
                  controller.update();
                });
                if (controller.widthVertical.value >= 100) {
                  controller.ontimerStop();
                }
                if (_pointer.dx == 180) {
                  _resetPosition();
                }
              }
            },
            onHorizontalDragEnd: (details) async {
              await Future.delayed(const Duration(seconds: 1));
              _resetPosition();
              setState(() {
                controller.widthVertical.value = 70;
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
          ),
        );
      },
    );
  }
}
