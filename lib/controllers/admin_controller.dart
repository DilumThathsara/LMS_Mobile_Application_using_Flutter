import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/fileUploadController.dart';
import 'package:proacademy_moodel/models/objects.dart';

class AdminController {
  //--- saving course details in cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Create a CollectionReference called course that references the firestore collection
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  //--- file upload controller object
  final fileUploadController _fileUploadController = fileUploadController();

  Future<void> saveCourseDetails(
    String courseName,
    String courseLanguage,
    String courseContent,
    String coursePrice,
    File file,
  ) async {
    final String downloadURL =
        await _fileUploadController.uploadFile(file, "courseImage");

    if (downloadURL != "") {
      await courses
          .add({
            'courseName': courseName,
            'courseLanguage': courseLanguage,
            'courseContent': courseContent,
            'coursePrice': coursePrice,
            'courseImage': downloadURL,
          })
          .then((value) => Logger().i("course Added"))
          .catchError((error) => Logger().e("Failed to add course: $error"));
    } else {
      Logger().e("Something when Wring");
    }
  }

  //---fetch course list from cloudfirestore

  Future<List<CourseModel>> fetchcourseList() async {
    try {
      //----firebase query that find and fetch product collection
      QuerySnapshot querySnapshot = await courses.get();
      Logger().i(querySnapshot.docs.length);

      //---temp course list
      List<CourseModel> list = [];

      for (var e in querySnapshot.docs) {
        //---- mapping course data in to course modul
        CourseModel model =
            CourseModel.fromJson(e.data() as Map<String, dynamic>);

        //---adding to the course list
        list.add(model);
      }

      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
