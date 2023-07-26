import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/components/custom_text.dart';
import 'package:proacademy_moodel/controllers/enroll_course_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/message/user/widget/user_card.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final List<EnrollCourseModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<userProvider, CourseProvider>(
        builder: (context, value, couseValue, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: EnrollCourseController()
                .getEnrollUsers(couseValue.getTempCourseModel.courseName),
            builder: (context, snapshot) {
              //---if snapshot error occurs
              if (snapshot.hasError) {
                return const Center(
                    child: CustomText("No users, Error Occured"));
              }
              //---if the strem is loading the data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              //---if no user yet
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: CustomText("No users"));
              }
              Logger().i(snapshot.data!.docs.length);

              //---clear the list before adding
              _list.clear();

              //---read the document list and mapping them to the user model and then add them to the list
              for (var item in snapshot.data!.docs) {
                Map<String, dynamic> data = item.data() as Map<String, dynamic>;
                var model = EnrollCourseModel.fromJson(data);
                _list.add(model);
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return UserCard(
                    model: _list[index].userModel,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: _list.length,
              );
            },
          );
        },
      ),
    );
  }
}
