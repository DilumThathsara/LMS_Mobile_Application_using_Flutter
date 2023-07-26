import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

class UtilFunctions {
  //---------navoigator function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  //navigator pop function
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  //--- select Course image
  static Future<File> pickImageFromGallry() async {
    try {
      File image = File("");
      // Pick an image
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      //---- check if the user has picked the file or not
      if (pickedFile != null) {
        //----- assogning the picked xfile object to the file
        image = File(pickedFile.path);

        return image;
      } else {
        Logger().e("No Image selected");
        return File("");
      }
    } catch (e) {
      Logger().e(e);
      return File("");
    }
  }

  //---get time ago
  static String getTimeAgo(String date) => timeago.format(DateTime.parse(date));
}
