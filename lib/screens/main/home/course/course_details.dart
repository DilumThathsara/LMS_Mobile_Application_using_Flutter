import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_button.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/providers/enroll_course_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
  });

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(18, 26, 64, 1.0),
          body: Consumer<CourseProvider>(
            builder: (context, value, child) {
              return SizedBox(
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
                        value.getTempCourseModel.courseName,
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width,
                                height: 310,
                                decoration: const BoxDecoration(
                                  color: Color(0xffEEE0F8),
                                ),
                                child: Image.network(
                                  value.getTempCourseModel.courseImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const CustomText(
                                    'Course Language : ',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  CustomText(
                                    value.getTempCourseModel.courseLanguage,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const CustomText(
                                    'Course Price : ',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  CustomText(
                                    'Rs.${value.getTempCourseModel.coursePrice}/month',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                value.getTempCourseModel.courseContent,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: Consumer3<EnrollCourseProvider,
                                    userProvider, CourseProvider>(
                                  builder:
                                      (context, value, Uvalue, cvalue, child) {
                                    return CustomButton(
                                      text: "Enroll this Course",
                                      onTap: () {
                                        value.stratSaveEnrollCourseDetails(
                                            Uvalue.userModel!,
                                            cvalue.getTempCourseModel,
                                            context);
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
