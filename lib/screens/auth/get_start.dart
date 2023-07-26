import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/screens/auth/login.dart';
import 'package:proacademy_moodel/screens/auth/signup.dart';
import 'package:proacademy_moodel/utils/assets_constants.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';

class GetStatePage extends StatefulWidget {
  const GetStatePage({super.key});

  @override
  State<GetStatePage> createState() => _GetStatePageState();
}

class _GetStatePageState extends State<GetStatePage> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.getStart,
                  width: 400,
                  height: 400,
                ),
                CustomButton(
                  text: 'Get Start',
                  onTap: () {
                    UtilFunctions.navigateTo(context, const Login());
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      "Don't have an account ?",
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        UtilFunctions.navigateTo(context, SignUp());
                      },
                      child: const CustomText(
                        "Register",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
