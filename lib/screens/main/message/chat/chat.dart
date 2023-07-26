import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/chat_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/message/chat/widget/Message_typing_widget.dart';
import 'package:proacademy_moodel/screens/main/message/chat/widget/chat_bubble.dart';
import 'package:proacademy_moodel/screens/main/message/chat/widget/chat_header_widget.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.conId});

  final String conId;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<MessageModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const chatHeader(),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: ChatController().getMessages(widget.conId),
              builder: (context, snapshot) {
                //---if snapshot error occurs
                if (snapshot.hasError) {
                  return const Center(
                      child: CustomText("No Messages, Error Occured"));
                }
                //---if the strem is loading the data
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                //---if no user yet
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: CustomText("No Messages"));
                }
                Logger().i(snapshot.data!.docs.length);

                //---clear the list before adding
                _list.clear();

                //---read the document list and mapping them to the user model and then add them to the list
                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;
                  var model = MessageModel.fromJson(data);
                  _list.add(model);
                }

                return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Consumer<userProvider>(
                          builder: (context, value, child) {
                            return ChatBubble(
                              isSender:
                                  _list[index].senderId == value.userModel!.uid,
                              model: _list[index],
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: _list.length),
                );
              },
            ),
            const MessageTypingWidget(),
          ],
        ),
      ),
    );
  }
}
