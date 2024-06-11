import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';

class onLongPressUpFormfield extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('0:05',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: true,
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText(
                              speed: Duration(milliseconds: 50),
                              '၊၊||၊|။||||။၊|။|၊၊||၊|။||||။၊|။|၊၊||၊|။||||။၊|။',
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 152, 152, 152)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.buttonLongPressup.value = false;
                          controller.update();
                        },
                        icon: const Icon(Icons.delete_outlined)),
                    const Padding(
                        padding: EdgeInsets.only(left: 130),
                        child: Icon(
                          Icons.pause_outlined,
                          color: Colors.red,
                        ))
                  ],
                )
              ],
            ));
  }
}
