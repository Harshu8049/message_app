import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class SingleImage extends StatefulWidget {
  const SingleImage({super.key, required this.index});
  final int? index;

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  @override
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
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(1.5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.file(
                  height: 400,
                  File(imagePaths[0]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 220,
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        DateFormat.Hm().format(DateTime.now())),
                    const Icon(
                      size: 15,
                      Icons.done_all,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}
