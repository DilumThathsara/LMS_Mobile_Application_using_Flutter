import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/auth_controller.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/assets_constants.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //---auth controller object
  final AuthController _authController = AuthController();
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<userProvider>(context, listen: false).initializeUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomIn(
              child: Image.asset(
                AssetConstants.logo,
                width: 200,
                height: 200,
              ),
            ),
            // const SizedBox(height: 5),
            Pulse(
              child: const Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
