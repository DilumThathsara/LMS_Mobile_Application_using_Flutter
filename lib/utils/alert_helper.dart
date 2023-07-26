import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

// class AlertHelper {
//   //-------a function to show alert dialog box
//   static Future<dynamic> showAlert(
//     BuildContext context,
//     DialogType dialogType,
//     String title,
//     String desc,
//   ) async {
//     return AwesomeDialog(
//       context: context,
//       dialogType: dialogType,
//       animType: AnimType.BOTTOMSLIDE,
//       title: title,
//       desc: desc,
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {},
//     ).show();
//   }

//   //---show snackbar function
//   static void showSnackBar(
//       String msg, AnimatedSnackBarType type, BuildContext context) {
//     AnimatedSnackBar.material(
//       msg,
//       type: type,
//       duration: const Duration(milliseconds: 500),
//     ).show(context);
//   }
// }

class AlertHelper {
  //----show alert method
  static Future<void> showAlert(
    BuildContext context,
    String title,
    String desc,
    DialogType type,
  ) async {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.SCALE,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
