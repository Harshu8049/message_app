import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class SingleImage extends StatefulWidget {
  const SingleImage({super.key, required this.index});
  final int? index;

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[widget.index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).focusedChild?.unfocus();

            Get.to(PageViewImage(
                duringsend: false, imagePath: imagePaths, initalindex: 0));
          },
          child: Image.file(
            File(imagePaths[0]),
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
