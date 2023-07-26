part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  String id;
  List<String> users;
  List<UserModel> usersArray;
  String lastMessage;
  String lastMessageTime;
  String createdBy;

  ConversationModel(
    this.id,
    this.users,
    this.usersArray,
    this.lastMessage,
    this.lastMessageTime,
    this.createdBy,
  );

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
