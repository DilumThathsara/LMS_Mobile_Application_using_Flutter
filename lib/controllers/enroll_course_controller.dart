import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proacademy_moodel/models/objects.dart';

class EnrollCourseController {
  //--- Create a CollectionReference called with Enroll Course Details that references the firestore collection
  CollectionReference EnrollCourseDetails =
      FirebaseFirestore.instance.collection('EnrollCourseDetails');

  late DocumentReference _documentReference;
  late CollectionReference _collectionReference;

  //--- save extra Course Details in firestore
  Future<void> saveEnrollCourseDetails(
    UserModel userModel,
    CourseModel courseModel,
  ) async {
    String docId = userModel.uid + courseModel.courseName;
    await EnrollCourseDetails.doc(docId).set({
      'userModel': userModel.toJson(),
      'courseModel': courseModel.toJson(),
    });

    // _documentReference = EnrollCourseDetails.doc(userModel.uid);
    // _collectionReference = _documentReference.collection("EnrollSubject");

    // _collectionReference
    //     .doc(courseModel.courseName)
    //     .set(
    //       {
    //         'userModel': userModel.toJson(),
    //         'courseModel': courseModel.toJson(),
    //       },
    //     )
    //     .then((value) => Logger().i("Successfully added"))
    //     .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //stream query for fetch enroll data
  Stream<QuerySnapshot> getEnrollments(String uid) =>
      EnrollCourseDetails.where('userModel.uid', isEqualTo: uid).snapshots();

  //stream query for fetch enroll user data
  Stream<QuerySnapshot> getEnrollUsers(String courseName) =>
      EnrollCourseDetails.where('courseModel.courseName', isEqualTo: courseName)
          .snapshots();
}
