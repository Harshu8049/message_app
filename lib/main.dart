import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:message_app/mesaage_typing_field/sendButton.dart';
import 'package:message_app/controller/controller.dart';

import 'package:message_app/showdialog.dart';
import 'package:message_app/mesaage_typing_field/textformfield.dart';
import 'package:message_app/MessagesWindow/user_message.dart';

void main() {
  runApp(const MessageScreen());
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController controller = Get.put(MessageController());

  bool _switchuser = false;

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
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: UserMessage(switchUser: _switchuser),
                      ),
                      Row(
                        children: [
                          const TextFormFieldForMessage(),
                          const SizedBox(width: 10),
                          const SizedBox(width: 6),
                          AudioOrMessageSendButton(),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              if (controller.loader.value)
                const Opacity(opacity: 1, child: AppLoader()),
            ]),
          ),
        );
      },
    );
  }
}