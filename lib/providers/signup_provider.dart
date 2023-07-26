import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/auth_controller.dart';
import 'package:proacademy_moodel/utils/alert_helper.dart';

class SignupProvider extends ChangeNotifier {
  //--- firstName controller
  final _firstName = TextEditingController();

  //--- get firstName controller
  TextEditingController get firstNameController => _firstName;

  //--- lastName controller
  final _lastName = TextEditingController();

  //--- get lastName controller
  TextEditingController get lastNameController => _lastName;

  //--- birthDay controller
  final _birthDay = TextEditingController();

  //--- get birthDay controller
  TextEditingController get birthDayController => _birthDay;

  //--- age controller
  int _age = 0;

  //--- get age controller
  int get ageController => _age;

  void setAge(String date) {
    _age = DateTime.now().year - int.parse(date.substring(0, 4));
    notifyListeners();
  }

  //--- mobileNo controller
  final _mobileNo = TextEditingController();

  //--- get mobileNo controller
  TextEditingController get mobileNoController => _mobileNo;

  //--- gender controler
  String _gender = "";

  //--- get gender controller
  String get genderController => _gender;

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  // //--- female controler
  // bool _genderFemale = false;

  // //--- get gemale controller
  // bool get genderFemale => _genderFemale;

  // void setGenderFemale(bool value) {
  //   _genderFemale = value;
  //   notifyListeners();
  // }

  //--- Address controller
  final _address = TextEditingController();

  //--- get Address controller
  TextEditingController get addressController => _address;

  //--- school controller
  final _school = TextEditingController();

  //--- get school controller
  TextEditingController get schoolController => _school;

  //---email controler
  final _email = TextEditingController();

  //--- get email controller
  TextEditingController get emailController => _email;

  //---password controller
  final _password = TextEditingController();

  //--- get password controller
  TextEditingController get passwordController => _password;

  //---loading state
  bool _isLoading = false;

  //---get loader state
  bool get isLoading => _isLoading;

  //---set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---- signup functions
  Future<void> startSignup(BuildContext context) async {
    try {
      if (_firstName.text.isNotEmpty &&
          _lastName.text.isNotEmpty &&
          _birthDay.text.isNotEmpty &&
          _mobileNo.text.isNotEmpty &&
          _gender.isNotEmpty &&
          _address.text.isNotEmpty &&
          _school.text.isNotEmpty &&
          _email.text.isNotEmpty &&
          _password.text.isNotEmpty) {
        setLoader = true;

        //---start creating the user account
        await AuthController().signUpUser(
          _firstName.text,
          _lastName.text,
          _birthDay.text,
          _age,
          _mobileNo.text,
          _gender,
          _address.text,
          _school.text,
          _email.text,
          _password.text,
          context,
        );

        setLoader = false;
      } else {
        //-----shows a error dialog
        AlertHelper.showAlert(context, "Validation Error",
            "Fill All the Fields", DialogType.ERROR);
      }
    } catch (e) {
      Logger().e(e);
      setLoader = false;
    }
  }
}
