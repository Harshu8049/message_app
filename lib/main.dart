import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/mesaage_typing_field/SendButtom/send_button.dart';
import 'package:message_app/controller/controller.dart';
import 'package:message_app/mesaage_typing_field/camera_button.dart';
import 'package:message_app/showdialog.dart';
import 'package:message_app/mesaage_typing_field/textformfield.dart';
import 'package:message_app/MessagesWindow/user_message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MessageScreen());
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController controller = Get.put(MessageController());

  final bool _switchuser = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Scaffold(
            backgroundColor: const Color(0xFFece5dd),
            appBar: AppBar(
              toolbarHeight: 70,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              backgroundColor: const Color(0xFF075E54),
              title: const Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Stack(children: [
              Opacity(
                  opacity: controller.loader.value ? 0.5 : 1,
                  child: Stack(children: [
                    UserMessage(switchUser: _switchuser),
                    const Positioned(
                        bottom: 10,
                        left: 2,
                        child: TextFormFieldForMessage()),
                    const AudioOrMessageSendButton(),
                  ])),
              if (controller.loader.value)
                const Opacity(opacity: 1, child: AppLoader()),
            ]),
          ),
        );
      },
    );
  }
}
