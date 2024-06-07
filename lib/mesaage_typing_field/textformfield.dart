import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/mesaage_typing_field/attachfilebutton.dart';
import 'package:message_app/mesaage_typing_field/cameraButton.dart';
import 'package:message_app/mesaage_typing_field/emojibutton.dart';

class TextFormFieldForMessage extends StatelessWidget {
  const TextFormFieldForMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
              ),
              padding: const EdgeInsets.all(1),
              height: 50,
              width: MediaQuery.of(context).size.width - 70,
              child: TextFormField(
                controller: controller.sender,
                decoration: InputDecoration(
                  prefixIcon: EmojiButton(),
                  hintText: 'Message',
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(1),
                    width: 100,
                    child: Row(
                      children: [AttachFileButton(), CameraButton()],
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ));
  }
}
