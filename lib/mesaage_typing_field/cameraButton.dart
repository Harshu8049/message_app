import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';

class CameraButton extends StatefulWidget {
  @override
  State<CameraButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<CameraButton> {
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => IconButton(
              iconSize: 20,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                controller.loader.value = true;
                controller.update();

                await Future.delayed(const Duration(seconds: 5));

                controller.loader.value = false;
                controller.update();

                if (controller.sender.text.isNotEmpty) {
                  controller.messages.add({
                    'type': ['text'],
                    'content': [controller.sender.text],
                  });

                  controller.update();

                  controller.sender.clear();
                  controller.scrollController.animateTo(
                    controller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.linear,
                  );
                }
              },
              icon: const Icon(Icons.camera_alt_outlined),
            ));
  }
}
