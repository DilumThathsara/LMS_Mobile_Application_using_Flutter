// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['id'] as String,
      (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      (json['usersArray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastMessage'] as String,
      json['lastMessageTime'] as String,
      json['createdBy'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'usersArray': instance.usersArray.map((e) => e.toJson()).toList(),
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'createdBy': instance.createdBy,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as String? ?? "",
      courseName: json['courseName'] as String,
      courseLanguage: json['courseLanguage'] as String,
      courseContent: json['courseContent'] as String,
      coursePrice: json['coursePrice'] as String,
      courseImage: json['courseImage'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseName': instance.courseName,
      'courseLanguage': instance.courseLanguage,
      'courseContent': instance.courseContent,
      'coursePrice': instance.coursePrice,
      'courseImage': instance.courseImage,
    };

EnrollCourseModel _$EnrollCourseModelFromJson(Map<String, dynamic> json) =>
    EnrollCourseModel(
      userModel: UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      courseModel:
          CourseModel.fromJson(json['courseModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnrollCourseModelToJson(EnrollCourseModel instance) =>
    <String, dynamic>{
      'userModel': instance.userModel,
      'courseModel': instance.courseModel,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['conId'] as String,
      json['senderName'] as String,
      json['senderId'] as String,
      json['reciverId'] as String,
      json['message'] as String,
      json['messageTime'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'conId': instance.conId,
      'senderName': instance.senderName,
      'senderId': instance.senderId,
      'reciverId': instance.reciverId,
      'message': instance.message,
      'messageTime': instance.messageTime,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['birthDay'] as String,
      json['age'] as int,
      json['address'] as String,
      json['gender'] as String,
      json['mobileNo'] as String,
      json['school'] as String,
      json['img'] as String,
      json['lastSeen'] as String,
      json['isOnline'] as bool,
      json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDay': instance.birthDay,
      'age': instance.age,
      'address': instance.address,
      'gender': instance.gender,
      'mobileNo': instance.mobileNo,
      'school': instance.school,
      'img': instance.img,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'token': instance.token,
    };
