import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    this.isSender = true,
    required this.model,
  }) : super(key: key);

  final bool isSender;
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialThree(
          text: model.message,
          color: isSender ? const Color(0xFF1B97F3) : AppColors.kAsh,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          isSender: isSender,
          // delivered: true,
          // seen: true,
          // sent: true,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: CustomText(
            UtilFunctions.getTimeAgo(model.messageTime),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.kAsh,
          ),
        ),
      ],
    );
  }
}
