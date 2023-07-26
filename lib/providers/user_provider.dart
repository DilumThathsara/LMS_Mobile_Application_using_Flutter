import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/auth_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/course_provider.dart';
import 'package:proacademy_moodel/screens/auth/get_start.dart';
import 'package:proacademy_moodel/screens/main/mainScreen.dart';
import 'package:proacademy_moodel/utils/alert_helper.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

class userProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();

  //----initialize the user and listen to the auth state
  Future<void> initializeUser(BuildContext context) async {
    //--check user current auth state
    //-- register this lisnter
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        //--if user is  null, that means the auth state is sign out
        //-- to redeirect the user to signup page
        Logger().i('User is currently signed out!');
        UtilFunctions.navigateTo(context, const GetStatePage());
      } else {
        //--if user is not null, that means the auth state is login
        //-- to redeirect the user to home page
        Logger().i('User is signed in!');

        await startFetchUserData(user.uid, context).then(
          (value) {
            //---updating the online status to true before going to the home
            updateUserOnline(true);
            Provider.of<CourseProvider>(context, listen: false)
                .startFetchCourseDetails();

            fetchUser(user.uid).then(
              (value) {
                UtilFunctions.navigateTo(context, const MainScreen());
              },
            );
          },
        );
      }
    });
  }

  //---start fetch user data ----------
  //-- store fetch user model
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<void> startFetchUserData(String uid, BuildContext context) async {
    try {
      await _authController.fetchUserData(uid).then(
        (value) {
          //--check if fetch result is not null
          if (value != null) {
            _userModel = value;
            notifyListeners();
          } else {
            //--show an error
            AlertHelper.showAlert(context, "Error",
                "Error while fetching user data", DialogType.ERROR);
          }
        },
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  //----------upload and user image
  //---image picker class object
  final ImagePicker _picker = ImagePicker();

  //---product image object
  File _image = File("");

  //---get pick file
  File get image => _image;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoder(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //--- select product image
  Future<void> selectAndUploadProfileImage() async {
    try {
      // Pick an image
      _image = await UtilFunctions.pickImageFromGallry();
      if (_image.path != "") {
        //----start the loader
        setLoder = true;

        String imgUrl = await _authController.uploadAndIpdateProfileImage(
            _image, _userModel!.uid);
        if (imgUrl != "") {
          _userModel!.img = imgUrl;
          notifyListeners();
          setLoder = false;
        }
        setLoder = false;
      }
    } catch (e) {
      Logger().e(e);
      setLoder = false;
    }
  }

  // late UserModel _userModel;

  // UserModel? get userModel => _userModel;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---fetch singal user data
  Future<void> fetchUser(String uid) async {
    try {
      setLoading(true);
      await AuthController().fetchUserData(uid).then(
        (value) {
          if (value != null) {
            Logger().w(value.email);
            _userModel = value;
            notifyListeners();
            setLoading(false);
          }
        },
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  //--signOut user
  Future<void> signOutUser() async {
    //---updation the user offline status to false before login out
    await _authController.updateOnlineStatus(userModel!.uid, false);
    await FirebaseAuth.instance.signOut();
  }

  //---update the current user online status and the last seen
  void updateUserOnline(bool val) {
    try {
      _authController.updateOnlineStatus(userModel!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }

  //---update user model  token field with device token
  void setDeviceToken(String token) {
    _userModel!.token = token;
    notifyListeners();
  }
}
