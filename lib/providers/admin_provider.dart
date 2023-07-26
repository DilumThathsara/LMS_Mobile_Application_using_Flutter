import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/admin_controller.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';

class AdminProvider extends ChangeNotifier {
  //--admin contoller project
  final AdminController _adminController = AdminController();

  final ImagePicker _courseImgPicker = ImagePicker();

  //----Course Image Object
  File _courseimage = File("");

  //--- get picked file
  File get courseimage => _courseimage;

  //--- select course image
  Future<void> selectCourseImage() async {
    try {
      // Pick an image
      _courseimage = await UtilFunctions.pickImageFromGallry();
    } catch (e) {
      Logger().e(e);
    }
  }

  final _courseName = TextEditingController();
  TextEditingController get courseNameController => _courseName;

  final _courseLanguage = TextEditingController();
  TextEditingController get courseLanguageController => _courseLanguage;

  final _courseContent = TextEditingController();
  TextEditingController get courseContentController => _courseContent;

  final _coursePrice = TextEditingController();
  TextEditingController get coursePriceController => _coursePrice;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoder(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //--- start saving course data
  Future<void> startSaveCourseDetails() async {
    try {
      //-----start the loader
      setLoder = true;

      await _adminController
          .saveCourseDetails(
        _courseName.text,
        _courseLanguage.text,
        _courseContent.text,
        _coursePrice.text,
        _courseimage,
      )
          .then((value) {
        _courseName.clear();
        _courseLanguage.clear();
        _courseContent.clear();
        _coursePrice.clear();
        _courseimage = File("");

        notifyListeners();
      });

      //-----stop the loader
      setLoder = false;
    } catch (e) {
      Logger().e(e);
      setLoder = false;
    }
  }
}
