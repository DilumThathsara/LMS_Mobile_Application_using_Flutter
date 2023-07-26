import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/admin_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';

class CourseProvider extends ChangeNotifier {
  final AdminController _adminController = AdminController();

  //---start fetch Course details
  List<CourseModel> _CourseModel = [];
  List<CourseModel> get getCourseModel => _CourseModel;

  Future<void> startFetchCourseDetails() async {
    try {
      _CourseModel = await _adminController.fetchcourseList();
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //--- to store selected
  late CourseModel _tempCourseModel;

  CourseModel get getTempCourseModel => _tempCourseModel;

  //set Course model when clicked on the Course tile
  set setCourse(CourseModel model) {
    _tempCourseModel = model;
    notifyListeners();
  }
}
