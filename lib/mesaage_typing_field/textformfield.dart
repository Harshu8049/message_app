import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/mesaage_typing_field/SendButtom/onlongpressupform_field.dart';
import 'package:message_app/mesaage_typing_field/SendButtom/onlongpresstextformfield.dart';
import 'package:message_app/mesaage_typing_field/attachfilebutton.dart';
import 'package:message_app/mesaage_typing_field/camera_button.dart';
import 'package:message_app/mesaage_typing_field/emojibutton.dart';

class TextFormFieldForMessage extends StatelessWidget {
  const TextFormFieldForMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (controller) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white),
          ),
          padding: const EdgeInsets.all(1),
          height: controller.buttonLongPressup.value ? 100 : 50,
          width: MediaQuery.of(context).size.width -
              controller.widthVertical.value,
          child: Obx(
            () => controller.buttonLongPress.value
                ? const OnLongPressButtonTextFormField()
                : controller.buttonLongPressup.value
                    ? const OnLongPressUpFormfield()
                    : TextFormField(
                        controller: controller.senderMesaage,
                        onChanged: (value) {
                          controller.textLength.value = value.length;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const EmojiButton(),
                          hintText: 'Message',
                          suffixIcon: Obx(
                            () => controller.textLength.value == 0
                                ? Container(
                                    padding: const EdgeInsets.all(1),
                                    width: 100,
                                    child: const Row(
                                      children: [
                                        AttachFileButton(),
                                        CameraButton()
                                      ],
                                    ),
                                  )
                                : const AttachFileButton(),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
          ));
    });
  }
}
