import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';

// ignore: must_be_immutable
class TextMessage extends StatelessWidget {
  TextMessage({super.key, this.index});
  int? index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (controller) {
      var message = controller.messages[index!];
      List<String> text = List<String>.from(message['content']!);
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFdcf8c6)),
            padding: const EdgeInsets.all(10),
            child: Text(text[0]),
          ),
        ),
      );
    });
  }
}
