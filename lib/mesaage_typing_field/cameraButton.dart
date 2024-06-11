import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';

List<CameraDescription>? cameras;

class CameraButton extends StatefulWidget {
  @override
  State<CameraButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<CameraButton> {
  late CameraController? cameraController;
  late Future<void> cameraVAlue;
  String imagepath = '';

  void StartCamera(int camera) async {
    cameraController = CameraController(cameras![camera], ResolutionPreset.high,
        enableAudio: false);

    try {
      await cameraController!.initialize().then((value) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } on CameraException catch (e) {
      print('camera error $e');
    }
  }

  Future takePicture() async {
    if (!cameraController!.value.isInitialized) {
      return null;
    }
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController!.setFlashMode(FlashMode.off);
      XFile picture = await cameraController!.takePicture();
      imagepath = picture.path;
      print(imagepath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    StartCamera(0);
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<MessageController>(
        builder: (controller) => IconButton(
              color: Color.fromARGB(255, 121, 121, 121),
              iconSize: 20,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: cameraController!.value.isInitialized
                              ? Stack(children: [
                                  CameraPreview(cameraController!),
                                  Positioned(
                                      bottom: 20,
                                      right: 180,
                                      child: IconButton(
                                          iconSize: 40,
                                          onPressed: () {
                                            takePicture();
                                          },
                                          icon: const Icon(Icons.camera_alt))),
                                  if (imagepath != '')
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Image.file(File(imagepath)))
                                ])
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),
                      ),
                    );
                  },
                ));
              },
              icon: const Icon(Icons.camera_alt_outlined),
            ));
  }
}
