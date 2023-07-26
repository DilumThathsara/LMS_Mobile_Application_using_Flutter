import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/chat_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class chatHeader extends StatelessWidget {
  const chatHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        color: AppColors.primaryColor.withOpacity(0.8),
        child: Consumer2<ChatProvider, userProvider>(
          builder: (context, value, authvalue, child) {
            var temp = value.conversationModel.usersArray
                .firstWhere((e) => e.uid != authvalue.userModel!.uid);
            return Row(
              children: [
                IconButton(
                    onPressed: () {
                      UtilFunctions.goBack(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                      color: AppColors.kWhite,
                    )),
                Image.network(
                  // AssetConstants.profileImgUrl,
                  temp.img,
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    CustomText(
                      temp.firstName,
                      color: AppColors.kWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream:
                          ChatController().getPeerUserOnlineStatus(temp.uid),
                      builder: (context, snapshot) {
                        //---if snapshot error occurs
                        if (snapshot.hasError) {
                          return const Center(
                              child: CustomText("No Messages, Error Occured"));
                        }
                        //---if the strem is loading the data
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        Logger().i(snapshot.data!.data());

                        UserModel model = UserModel.fromJson(
                            snapshot.data!.data() as Map<String, dynamic>);

                        value.setPeerUser(model);

                        return CustomText(
                          model.isOnline
                              ? "Online"
                              : UtilFunctions.getTimeAgo(model.lastSeen),
                          color: AppColors.kWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
