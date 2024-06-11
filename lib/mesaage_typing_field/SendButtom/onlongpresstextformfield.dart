import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.mic_none,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(left: 100),
          child: AnimatedTextKit(
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
          ),
        )
      ],
    );
  }
}
