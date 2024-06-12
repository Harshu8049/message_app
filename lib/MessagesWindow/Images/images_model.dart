

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/MessagesWindow/Images/Four_or_more_Images/first_three_image.dart';
import 'package:message_app/MessagesWindow/Images/Four_or_more_Images/forthimage.dart';
import 'package:message_app/MessagesWindow/Images/singleimage.dart';
import 'package:message_app/controller/controller.dart';

class ImageModel extends StatefulWidget {
  const ImageModel({super.key, required this.index});

  final int? index;

  @override
  State<ImageModel> createState() => _SingleImageState();
}

class _SingleImageState extends State<ImageModel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        var message = controller.messages[widget.index!];
        List<String> imagePaths = List<String>.from(message['content']!);
        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 2.5, right: 1.5, left: 2.5, bottom: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFdcf8c6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: imagePaths.length > 2
                      ? 305.0
                      : imagePaths.length == 1
                          ? 350
                          : 155.0,
                  width: imagePaths.length == 1 ? 280 : 300,
                  child: imagePaths.length == 1
                      ? SingleImage(
                          index: widget.index,
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              imagePaths.length > 4 ? 4 : imagePaths.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            if (index == 3 && imagePaths.length > 4) {
                              return ForthImageOfGrid(
                                index: widget.index,
                              );
                            } else {
                              return FirstThreeIMageOFGrid(
                                  index: widget.index, imgindex: index);
                            }
                          },
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
