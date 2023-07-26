import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/screens/main/home/enroll%20course/course_content.dart';
import 'package:proacademy_moodel/screens/main/message/user/user.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class EnrollCourseDetails extends StatefulWidget {
  const EnrollCourseDetails({super.key});

  @override
  State<EnrollCourseDetails> createState() => _EnrollCourseDetailsState();
}

class _EnrollCourseDetailsState extends State<EnrollCourseDetails> {
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
              Align(
                alignment: Alignment.topCenter,
                child: CustomText(
                  Provider.of<CourseProvider>(context, listen: false)
                      .getTempCourseModel
                      .courseName,
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
                  child: const SizedBox(
                    height: 290,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: AppColors.kred,
                            labelStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText('Videos'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText('Enroll Student'),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Expanded(
                            child: TabBarView(
                              children: [
                                CourseContent(),
                                Users(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
