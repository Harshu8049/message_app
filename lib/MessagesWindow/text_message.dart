import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:message_app/controller/controller.dart';

// ignore: must_be_immutable
class TextMessage extends StatelessWidget {
  TextMessage({super.key, this.index});
  int? index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (controller) {
      var message = controller.messages[index!];
      List<String> text = List<String>.from(message['content']!);
      return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 10, maxWidth: 300),
              child: IntrinsicWidth(
                stepWidth: 1.0,
                stepHeight: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFdcf8c6)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Text(
                            text[0],
                            softWrap: true,
                            maxLines: null,
                          ),
                        ),
                        Positioned(
                          bottom: -4,
                          right: 0,
                          child: Row(
                            children: [
                              Text(
                                  style: const TextStyle(color: Colors.grey),
                                  '${DateFormat.Hm().format(DateTime.now())}'),
                              SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                size: 15,
                                Icons.done_all,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
