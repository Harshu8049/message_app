// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/pageview.dart';

List<CameraDescription>? cameras;

class CameraButton extends StatefulWidget {
  const CameraButton({super.key});
  @override
  State<CameraButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<CameraButton> {
  late CameraController? cameraController;
  late Future<void> cameraVAlue;
  String? imagepath;

  void startCamera(int camera) async {
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
      print(e);
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
      setState(() {
        imagepath = picture.path;
        print(imagepath);
      });

      List<String> path = [];
      path[0] = imagepath!;
      cameraController!.dispose();
      Get.to(() =>
          PageViewImage(duringsend: true, imagePath: path, initalindex: 0));
      print(imagepath);
    } on CameraException catch (e) {
      print("Issue is camer is $e");
      return null;
    }
  }

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => IconButton(
              color: const Color.fromARGB(255, 121, 121, 121),
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
                                      icon: const Icon(Icons.camera_alt),
                                    ),
                                  ),
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
