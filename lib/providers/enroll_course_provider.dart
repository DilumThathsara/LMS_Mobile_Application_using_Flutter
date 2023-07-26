import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/enroll_course_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/utils/alert_helper.dart';

class EnrollCourseProvider extends ChangeNotifier {
  final EnrollCourseController _enrollCourseController =
      EnrollCourseController();

  //---start saving Enroll Course data
  Future<void> stratSaveEnrollCourseDetails(
    UserModel userModel,
    CourseModel courseModel,
    BuildContext context,
  ) async {
    try {
      await _enrollCourseController.saveEnrollCourseDetails(
        userModel,
        courseModel,
      );
    } catch (e) {
      AlertHelper.showAlert(
          context, "Enroll error", "Check the all Details", DialogType.ERROR);
      Logger().e(e);
    }
  }

  //--- to store selected
  late EnrollCourseModel _tempEnrollCourseModel;

  EnrollCourseModel get getTempEnrollCourseModel => _tempEnrollCourseModel;

  //set Course model when clicked on the Course tile
  set setEnrollCourseModel(EnrollCourseModel model) {
    _tempEnrollCourseModel = model;
    notifyListeners();
  }
}
