import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:message_app/MessagesWindow/Images/images_model.dart';
import 'package:message_app/MessagesWindow/text_message.dart';
import 'package:message_app/controller/controller.dart';

// ignore: must_be_immutable
class UserMessage extends StatefulWidget {
  UserMessage({super.key, required this.switchUser});

  bool switchUser;
  @override
  State<StatefulWidget> createState() {
    return _UserMessage();
  }
}

class _UserMessage extends State<UserMessage> {
  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(bottom: context.mediaQueryViewInsets.bottom),
        height: Get.height,
        width: Get.width,
        child: Obx(
          () {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, listindex) {
                      var message = controller.messages[listindex];
                      if (message['type']!.contains('images')) {
                        return ImageModel(
                          index: listindex,
                        );
                      } else if (message['type']!.contains('text')) {
                        return TextMessage(
                          index: listindex,
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      Obx(() => controller.buttonLongPress.value
          ? Positioned(
              bottom: 0,
              right: 4,
              child: Container(
                height: 150,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: AnimatedOpacity(
                        opacity: controller.buttonLongPress.value ? 1.0 : 0.5,
                        duration: const Duration(milliseconds: 300),
                        child: Obx(
                          () => Icon(
                            !controller.buttonLongPressup.value
                                ? Icons.lock_open
                                : Icons.lock,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      WavyAnimatedText(
                        speed: Duration(seconds: 1),
                        'ᐱ',
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 115, 114, 114)),
                      )
                    ],
                  ),
                ]),
              ),
            )
          : Text('')),
    ]);
  }
}
