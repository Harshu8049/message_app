import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class ForthImageOfGrid extends StatelessWidget {
  const ForthImageOfGrid({super.key, required this.index});

  final int? index;
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return Stack(children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).focusedChild?.unfocus();
              Get.to(PageViewImage(
                  duringsend: false,
                  imagePath: imagePaths,
                  initalindex: index!));
            },
            child: Padding(
              padding: const EdgeInsets.all(0.80),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  width: 200,
                  File(imagePaths[index!]),
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).focusedChild?.unfocus();
              Get.to(PageViewImage(
                  duringsend: false,
                  imagePath: imagePaths,
                  initalindex: index!));
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
          ),
          Positioned(
            bottom: 0,
            left: 90,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      style: const TextStyle(color: Colors.grey),
                      '${DateFormat.Hm().format(DateTime.now())}'),
                  const Icon(
                    size: 15,
                    Icons.done_all,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          )
        ]);
      },
    );
  }
}
