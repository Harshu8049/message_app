import 'package:flutter/material.dart';
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

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isListening = false;

  String? _text;
  late stt.SpeechToText _speech;
  void _onTap() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward().then((value) => _listen());
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
            controller.sender.text += _text!;
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
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            _controller.reverse();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          decoration: const ShapeDecoration(
            color: Color(0xFF128C7E),
            shape: CircleBorder(),
          ),
          alignment: Alignment.center,
          height: 50,
          width: 50,
          child: IconButton(
            iconSize: 20,
            onPressed: _listen,
            icon: Icon(
              color: Colors.white,
              controller.sender.text.length.toInt() == 0
                  ? Icons.mic
                  : Icons.send,
            ),
          ),
        ),
      ),
    );
  }
}
