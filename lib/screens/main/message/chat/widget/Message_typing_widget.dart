import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class MessageTypingWidget extends StatelessWidget {
  const MessageTypingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBar(onSend: (String msg) {
      Logger().w(msg);
      if (msg.trim().isNotEmpty) {
        //---start sending msg
        Provider.of<ChatProvider>(context, listen: false)
            .startSendMessage(context, msg);
      }
    }
        // actions: [
        //   InkWell(
        //     child: const Icon(
        //       Icons.add,
        //       color: Colors.black,
        //       size: 24,
        //     ),
        //     onTap: () {},
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(left: 8, right: 8),
        //     child: InkWell(
        //       child: const Icon(
        //         Icons.camera_alt,
        //         color: Colors.green,
        //         size: 24,
        //       ),
        //       onTap: () {},
        //     ),
        //   ),
        // ],
        );
  }
}
