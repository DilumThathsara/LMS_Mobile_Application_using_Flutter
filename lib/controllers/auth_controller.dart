import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/fileUploadController.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/utils/alert_helper.dart';
import 'package:proacademy_moodel/utils/assets_constants.dart';

class AuthController {
  //--- signup user

  Future<void> signUpUser(
    String firstName,
    String lastName,
    String birthDay,
    int age,
    String mobileNo,
    String gender,
    String address,
    String school,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      //--creating the user in the firebase console
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //---check if user obejct is not null
      if (credential.user != null) {
        //---save extra user data in firestore cloud
        saveUserData(
          credential.user!.uid,
          firstName,
          lastName,
          birthDay,
          age,
          mobileNo,
          gender,
          address,
          school,
          email,
          password,
          context,
        );
      }

      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
    } catch (e) {
      Logger().e(e);
    }
  }

  //---save the user data in cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //--- Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //----save extra user data in firestore
  Future<void> saveUserData(
    //UserModel model
    String uid,
    String firstName,
    String lastName,
    String birthDay,
    int age,
    String mobileNo,
    String gender,
    String address,
    String school,
    String email,
    String password,
    BuildContext context,
  ) {
    return users
        .doc(uid)
        .set(
          {
            //model.toJson,
            'uid': uid,
            'firstName': firstName,
            'lastName': lastName,
            'birthDay': birthDay,
            'age': age,
            'mobileNo': mobileNo,
            'gender': gender,
            'address': address,
            'school': school,
            'email': email,
            'img': AssetConstants.profileImgUrl,
            'lastSeen': DateTime.now().toString(),
            'isOnline': true,
            'token': "",
          },
        )
        .then((value) => Logger().i("Successfully added"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //---login user
  static Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      //----start login in the user in the firebase console
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.ERROR);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.ERROR);
    }
  }

  //----reset password email
  static Future<void> sendResetPassEmail(
      String email, BuildContext context) async {
    try {
      //----start sending apassword reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.ERROR);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.ERROR);
    }
  }

  //---fetch userdata from cloudfirestore

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //----------------firebase query that find and fetch user data according to the uid
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Logger().i(documentSnapshot.data());

      //---mapping fetched data user data into usermodel

      UserModel model =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //---upload user Image
  final fileUploadController _fileUploadController = fileUploadController();

  //-------- upload picked Image File to firebase Storage
  Future<String> uploadAndIpdateProfileImage(File file, String uid) async {
    try {
      //---- first upload and get the download link of the picker image
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "profileImages");

      if (downloadUrl != "") {
        //--- updating the uploaded file download url in the in the user data
        await users.doc(uid).update({
          'img': downloadUrl,
        });

        return downloadUrl;
      } else {
        Logger().e("Download URL is Empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

  // //--signOut user
  // static Future<void> signOutUser() async {
  //   _authController.updateOnlineStatus(userModel!.uid, val);
  //   await FirebaseAuth.instance.signOut();
  // }

  //---update the current users online states and the last since
  Future<void> updateOnlineStatus(String uid, bool isOnline) async {
    await users
        .doc(uid)
        .update(
          {
            "isOnline": isOnline,
            "lastSeen": DateTime.now().toString(),
          },
        )
        .then(
          (value) => Logger().i("Online status updated"),
        )
        .catchError(
          (error) => Logger().i("Failed to update: $error"),
        );
  }
}
