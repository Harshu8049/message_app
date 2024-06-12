// ignore_for_file: must_be_immutable, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class FirstThreeIMageOFGrid extends StatelessWidget {
  FirstThreeIMageOFGrid(
      {super.key, required this.index, required this.imgindex});

  int? index;
  int? imgindex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).focusedChild?.unfocus();
            Get.to(PageViewImage(
                duringsend: false,
                imagePath: imagePaths,
                initalindex: imgindex!));
          },
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(1.5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.file(
                    width: 200, File(imagePaths[imgindex!]), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 90,
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
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
          ]),
        );
      },
    );
  }
}
