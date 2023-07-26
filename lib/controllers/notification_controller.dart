import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class NotificationController {
  //-- firebase auth instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //--- Create a Collection Reference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //--- save user device token in the user details
  Future<void> saveNotificationToken(String uid, String token) async {
    await users
        .doc(uid)
        .update({
          "token": token,
        })
        .then((value) => Logger().i("Device token updated"))
        .catchError((error) => Logger().i("Failed to update: $error"));
  }
}
