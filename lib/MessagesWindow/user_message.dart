import 'package:flutter/material.dart';

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
    return Container(
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
    );
  }
}
