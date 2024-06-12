import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:message_app/controller/controller.dart';

class OnLongPressButtonTextFormField extends StatefulWidget {
  const OnLongPressButtonTextFormField({super.key});

  @override
  State<OnLongPressButtonTextFormField> createState() =>
      _OnLongPressButtonTextFormFieldState();
}

class _OnLongPressButtonTextFormFieldState
    extends State<OnLongPressButtonTextFormField>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (controller) {
      return Row(
        children: [
          if (controller.widthVertical.value <= 100)
            const Icon(
              Icons.mic_none,
              color: Colors.red,
            )
          else
            Lottie.asset(
                animate: true,
                repeat: false,
                fit: BoxFit.fill,
                'assests/Animation1.json'),
          const SizedBox(width: 10),
          if (controller.widthVertical.value <= 100)
            Obx(() {
              return
              Text(controller.formatedTime(controller.millisecond.value),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ));
                  
            }),
          SizedBox(
            width: 30,
          ),
          AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                scalingFactor: 1,
                duration: const Duration(seconds: 2),
                'ᐸ   Slide To Cancel',
                textStyle:
                    const TextStyle(color: Color.fromARGB(255, 152, 152, 152)),
              )
            ],
          )
        ],
      );
    });
  }
}
