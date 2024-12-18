import 'package:app/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageSoundLength extends StatelessWidget {
  const MessageSoundLength(
      {super.key,
      required this.size,
      required this.message,
      required this.color});

  final Size size;
  final MessageModel message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: size.width * .01,
      left: size.width * .01,
      child: Text(
        message.messageSoundTime!,
        style: TextStyle(fontSize: size.width * .025, color: color),
      ),
    );
  }
}
