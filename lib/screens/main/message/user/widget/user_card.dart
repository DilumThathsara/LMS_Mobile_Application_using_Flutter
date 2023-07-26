import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final UserModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          Row(
            children: [
              Image.network(
                model.img,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        model.firstName,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        model.lastName,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 5),
                      if (model.isOnline)
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: AppColors.lightGreen,
                        )
                    ],
                  ),
                  CustomText(
                    model.isOnline
                        ? "Online"
                        : UtilFunctions.getTimeAgo(model.lastSeen),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kAsh,
                  ),
                ],
              )
            ],
          ),
          model.uid !=
                  Provider.of<userProvider>(context, listen: false)
                      .userModel!
                      .uid
              ? Consumer<ChatProvider>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () =>
                          value.startCreateConversation(context, model, index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightBlue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                      ),
                      child: value.loadingIndex == index
                          ? const SpinKitCircle(
                              color: Colors.white,
                              size: 20,
                            )
                          : const CustomText(
                              'Chat',
                              color: AppColors.kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                    );
                  },
                )
              : Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
