import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/MessagesWindow/Images/Four_or_more_Images/first_three_image.dart';
import 'package:message_app/MessagesWindow/Images/Four_or_more_Images/forthimage.dart';
import 'package:message_app/MessagesWindow/Images/singleimage.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class ImageModel extends StatefulWidget {
  const ImageModel({super.key, required this.index});

  final int? index;

  @override
  State<ImageModel> createState() => _SingleImageState();
}

class _SingleImageState extends State<ImageModel> {
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[widget.index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: imagePaths.length > 2
                  ? 200.0
                  : imagePaths.length == 1
                      ? 250
                      : 100.0,
              width: 200,
              child: imagePaths.length == 1
                  ? SingleImage(
                      index: widget.index,
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: imagePaths.length > 4 ? 4 : imagePaths.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        if (index == 3 && imagePaths.length > 4) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              FirstThreeImages(
                                index: widget.index,
                              ),
                              ForthImage(index: index),
                            ],
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).focusedChild?.unfocus();
                              Get.to(PageViewImage(
                                  duringsend: false,
                                  imagePath: imagePaths,
                                  initalindex: index));
                            },
                            child: Image.file(File(imagePaths[index]),
                                fit: BoxFit.cover),
                          );
                        }
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
