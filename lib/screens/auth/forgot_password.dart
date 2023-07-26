import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/components/custom_textfield.dart';
import 'package:proacademy_moodel/providers/login_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class FogotPassword extends StatefulWidget {
  const FogotPassword({super.key});

  @override
  State<FogotPassword> createState() => _FogotPasswordState();
}

class _FogotPasswordState extends State<FogotPassword> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: 310,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(18, 26, 64, 1.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
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
                        const SizedBox(width: 45),
                        const CustomText(
                          'Forgot Password',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "PRO",
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 234, 171),
                          ),
                          CustomText(
                            "ACADEMY",
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 3, 30, 117),
                          ),
                        ],
                      ),
                      const CustomText(
                        "Moodel",
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 80),
                      const CustomText(
                        'Please,enter your email address.You will receive a link to create a new password via email.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      CustomTextfield(
                        hintTxt: "Email",
                        controller:
                            Provider.of<LoginProvider>(context).resetEmail,
                      ),
                      const SizedBox(height: 35),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) {
                          return CustomButton(
                              isLoading: value.isLoading,
                              onTap: () {
                                value.startSendPasswordResetEmail(context);
                              },
                              text: 'Send');
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
