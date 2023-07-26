part of 'objects.dart';

@JsonSerializable()
class EnrollCourseModel {
  UserModel userModel;
  CourseModel courseModel;

  EnrollCourseModel({
    required this.userModel,
    required this.courseModel,
  });

  factory EnrollCourseModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollCourseModelFromJson(json);

  get password => null;

  Map<String, dynamic> toJson() => _$EnrollCourseModelToJson(this);
}
