import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/chat_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/message/conversation/widget/conversation_card.dart';
import 'package:proacademy_moodel/screens/main/message/conversation/widget/header_widget.dart';
import 'package:provider/provider.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  final List<ConversationModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          const SizedBox(height: 10),
          Consumer<userProvider>(
            builder: (context, value, child) {
              return StreamBuilder<QuerySnapshot>(
                stream: ChatController().getConversations(value.userModel!.uid),
                builder: (context, snapshot) {
                  //---if snapshot error occurs
                  if (snapshot.hasError) {
                    return const Center(
                        child: CustomText("No Conversations, Error Occured"));
                  }
                  //---if the strem is loading the data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  //---if no user yet
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: CustomText("No Conversations"));
                  }
                  Logger().i(snapshot.data!.docs.length);

                  //---clear the list before adding
                  _list.clear();

                  //---read the document list and mapping them to the user model and then add them to the list
                  for (var item in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        item.data() as Map<String, dynamic>;
                    var model = ConversationModel.fromJson(data);
                    _list.add(model);
                  }

                  Provider.of<ChatProvider>(context, listen: false)
                      .setConvList(_list);

                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ConversationCard(model: _list[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: _list.length,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
