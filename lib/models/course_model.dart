part of 'objects.dart';

@JsonSerializable()
class CourseModel {
  String id;
  String courseName;
  String courseLanguage;
  String courseContent;
  String coursePrice;
  String courseImage;

  CourseModel({
    this.id = "",
    required this.courseName,
    required this.courseLanguage,
    required this.courseContent,
    required this.coursePrice,
    required this.courseImage,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  get password => null;

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
