import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/components/custom_textfield.dart';
import 'package:proacademy_moodel/providers/login_provider.dart';
import 'package:proacademy_moodel/screens/auth/forgot_password.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                child: const Column(
                  children: [
                    SizedBox(height: 20),
                    CustomText(
                      'Login',
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
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
                      CustomTextfield(
                        hintTxt: "Email",
                        controller:
                            Provider.of<LoginProvider>(context).emailController,
                      ),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        hintTxt: "Password",
                        controller: Provider.of<LoginProvider>(context)
                            .passwordController,
                        isObscure: true,
                      ),
                      const SizedBox(height: 35),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) {
                          return CustomButton(
                              isLoading: value.isLoading,
                              onTap: () {
                                value.startSignin(context);
                              },
                              text: 'LogIn');
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          UtilFunctions.navigateTo(context, FogotPassword());
                        },
                        child: const CustomText(
                          'Forgot your password?',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
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
