import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/enroll_course_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/home/enroll%20course/enroll_course_details.dart';
import 'package:proacademy_moodel/utils/app_colors.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

Consumer2 enrollCourceGrid() {
  List<EnrollCourseModel> listEnrollCourse = [];
  return Consumer2<CourseProvider, userProvider>(
    builder: (context, value, value2, child) {
      return StreamBuilder<QuerySnapshot>(
          stream:
              EnrollCourseController().getEnrollments(value2.userModel!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CustomText(
                  "No messages, error occured",
                  fontSize: 20,
                  color: AppColors.ashBorder,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            Logger().wtf(snapshot.data!.docs.length);
            listEnrollCourse.clear();

            for (var e in snapshot.data!.docs) {
              Map<String, dynamic> data = e.data() as Map<String, dynamic>;
              var model = EnrollCourseModel.fromJson(data);

              listEnrollCourse.add(model);
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listEnrollCourse.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      value.setCourse = value.getCourseModel[index];
                      UtilFunctions.navigateTo(
                          context, const EnrollCourseDetails());
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            Center(
                              child: Container(
                                width: 175,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        value.getCourseModel[index].courseImage,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomText(
                              value.getCourseModel[index].courseName,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
    },
  );
}
