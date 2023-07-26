import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/message/chat/chat.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ConversationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //---set Conversation Model before going to the chat screen
        Provider.of<ChatProvider>(context, listen: false)
            .setConversationModel(model);

        //---then go the chat screen
        UtilFunctions.navigateTo(
            context,
            Chat(
              conId: model.id,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(color: AppColors.kWhite, boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: AppColors.ashBorder,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<userProvider>(
              builder: (context, value, child) {
                return Row(
                  children: [
                    Image.network(
                      model.usersArray
                          .firstWhere((e) => e.uid != value.userModel!.uid)
                          .img,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              model.usersArray
                                  .firstWhere(
                                      (e) => e.uid != value.userModel!.uid)
                                  .firstName,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              model.usersArray
                                  .firstWhere(
                                      (e) => e.uid != value.userModel!.uid)
                                  .lastName,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        CustomText(
                          model.lastMessage,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kAsh,
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            CustomText(
              UtilFunctions.getTimeAgo(model.lastMessageTime),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.kAsh,
            ),
          ],
        ),
      ),
    );
  }
}
