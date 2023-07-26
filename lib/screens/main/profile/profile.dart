import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<userProvider>(
      builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: CustomText(
                      'Profile',
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Positioned(
                    top: 65,
                    child: Container(
                      width: size.width,
                      height: size.height,
                      padding: const EdgeInsets.fromLTRB(29, 34, 29, 0),
                      decoration: const BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => value.selectAndUploadProfileImage(),
                            child: value.isLoading
                                ? const CircularProgressIndicator()
                                : Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      border: Border.all(
                                          color: Colors.grey, width: 2),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(value.userModel!.img),
                                      ),
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              const CustomText(
                                'Name :- ',
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 15),
                              CustomText(
                                value.userModel!.firstName,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 4),
                              CustomText(
                                value.userModel!.lastName,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const CustomText(
                                'Email :- ',
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 15),
                              CustomText(
                                value.userModel!.email,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 200),
                          CustomButton(
                            text: 'Log Out',
                            onTap: () {
                              value.signOutUser();
                            },
                          ),
                          // const SizedBox(height: 20),
                          // CustomButton(
                          //   text: 'Admin',
                          //   onTap: () {
                          //     UtilFunctions.navigateTo(
                          //         context, const Admin());
                          //   },
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
