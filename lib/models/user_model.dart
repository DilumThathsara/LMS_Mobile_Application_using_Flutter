part of 'objects.dart';

@JsonSerializable()
class UserModel {
  String uid;
  String email;
  String firstName;
  String lastName;
  String birthDay;
  int age;
  String address;
  String gender;
  String mobileNo;
  String school;
  String img;
  String lastSeen;
  bool isOnline;
  @JsonKey(defaultValue: "")
  String token;

  UserModel(
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.birthDay,
    this.age,
    this.address,
    this.gender,
    this.mobileNo,
    this.school,
    this.img,
    this.lastSeen,
    this.isOnline,
    this.token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  get password => null;

  get name => null;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
