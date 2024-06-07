import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class ForthImage extends StatelessWidget {
  ForthImage({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[index];
        List<String> imagePaths = List<String>.from(message['content']!);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).focusedChild?.unfocus();
            Get.to(PageViewImage(
                duringsend: false, imagePath: imagePaths, initalindex: 3));
          },
          child: Center(
            child: Text(
              '+${imagePaths.length - 3}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
