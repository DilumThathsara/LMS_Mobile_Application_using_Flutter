import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/notification_controller.dart';
import 'package:proacademy_moodel/providers/chat_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();

  //----initialize notification and get the device token
  Future<void> initNotification(BuildContext context) async {
    // Get the token each time the application loads
    await FirebaseMessaging.instance.getToken().then(
      (value) {
        Logger().wtf(value);
        startSaveToken(context, value!);
      },
    );
  }

  //--- save notification token in db
  Future<void> startSaveToken(BuildContext context, String token) async {
    try {
      //---first get the user uid from usermodel
      String uid =
          Provider.of<userProvider>(context, listen: false).userModel!.uid;

      //---then start saving
      await _notificationController.saveNotificationToken(uid, token).then(
        (value) {
          //---updating the token fields with device token
          Provider.of<userProvider>(context, listen: false)
              .setDeviceToken(token);
        },
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  //--handel forground notification
  void forgroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().w('Got a message whilst in the foreground!');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().wtf(
            'Message also contained a notification: ${message.notification!.toMap()}');
      }
    });
  }

  //---handle when click on the notification and open the app
  void onClickedOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().w('Click notification to open the app');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Provider.of<ChatProvider>(context, listen: false)
            .setNotificationData(context, message.data['conId']);
      }
    });
  }
}
