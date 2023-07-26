import 'package:flutter/material.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/screens/main/home/course/course_details.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

Consumer AllCourceGrid() {
  return Consumer<CourseProvider>(
    builder: (context, value, child) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: value.getCourseModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                value.setCourse = value.getCourseModel[index];
                UtilFunctions.navigateTo(context, const CourseDetails());
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
    },
  );
}
