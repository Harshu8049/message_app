import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

class AttachFileButton extends StatefulWidget {
  @override
  State<AttachFileButton> createState() => _AttachFileButtonState();
}

List<XFile> pickedImages = [];

class _AttachFileButtonState extends State<AttachFileButton> {
  final MessageController controllers = Get.put(MessageController());
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => IconButton(
              color: Color.fromARGB(255, 121, 121, 121),
              iconSize: 25,
              onPressed: () async {
                pickedImages = await ImagePicker().pickMultiImage();

                controller.loader.value = true;
                controllers.update();

                await Future.delayed(const Duration(seconds: 5));

                controller.loader.value = false;
                controllers.update();

                List<String> path = [];

                for (var image in pickedImages) {
                  path.add(image.path);
                }

                if (path.isEmpty) {
                  return;
                } else {
                  await Get.to(PageViewImage(
                    duringsend: true,
                    imagePath: path,
                    initalindex: 0,
                  ));
                }
                if (path.isNotEmpty) {
                  controller.messages.add({
                    'type': ['images'],
                    'content': path,
                  });
                  controller.scrollController.animateTo(
                    controller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.linear,
                  );
                }

                controller.update();
              },
              icon: const Icon(Icons.attach_file_outlined),
            ));
  }
}
