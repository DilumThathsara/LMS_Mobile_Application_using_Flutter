import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/home/course/all_course_grid.dart';
import 'package:proacademy_moodel/screens/main/home/enroll%20course/enroll_course_grid.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<userProvider>(
      builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'Hello ${value.userModel!.firstName} !',
                            color: AppColors.kBlack,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    value.userModel!.img,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),

                          // IconButton(
                          //   onPressed: () {
                          //     value.signOutUser();
                          //   },
                          //   icon: const Icon(
                          //     Icons.logout,
                          //     size: 25,
                          //     color: AppColors.kBlack,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    "My Courses  ->",
                    color: AppColors.kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 300,
                    child: enrollCourceGrid(),
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    "All Courses  ->",
                    color: AppColors.kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 300,
                    child: AllCourceGrid(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
