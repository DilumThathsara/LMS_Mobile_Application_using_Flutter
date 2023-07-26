import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class fileUploadController {
  //----------upload picked image to the firebase storage bucket in the given directry path
  Future<String> uploadFile(File file, String folderPath) async {
    try {
      //----get in the file name from the file path
      final String fileName = basename(file.path);

      //-------define the firebase storage destination
      final String destination = "$folderPath/$fileName";

      //---------creating the firebase storage reference with the destination dile location
      final ref = FirebaseStorage.instance.ref(destination);

      //-----uploading the file
      UploadTask task = ref.putFile(file);
      //---- wait untill the uploading task is completed
      final snapshot = await task.whenComplete(() {});

      //--finaly getting the document url
      final String downloadURL = await snapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
