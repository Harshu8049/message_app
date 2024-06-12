import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  const EmojiButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.emoji_emotions_outlined,
        color: Color.fromARGB(255, 121, 121, 121),
      ),
    );
  }
}
