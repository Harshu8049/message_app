import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class FirstThreeImages extends StatelessWidget {
  const FirstThreeImages({super.key, required this.index});

  final int? index;
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).focusedChild?.unfocus();
            Get.to(PageViewImage(
                duringsend: false, imagePath: imagePaths, initalindex: index!));
          },
          child: Image.file(
            File(imagePaths[index!]),
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
        );
      },
    );
  }
}
