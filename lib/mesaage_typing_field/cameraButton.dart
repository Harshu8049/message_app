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
              color: Color.fromARGB(255, 121, 121, 121),
              iconSize: 20,
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
            ));
  }
}
