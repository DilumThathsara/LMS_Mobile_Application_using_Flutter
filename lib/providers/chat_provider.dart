import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/controllers/chat_controller.dart';
import 'package:proacademy_moodel/models/objects.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/utils/util_functions.dart';
import 'package:provider/provider.dart';

import '../screens/main/message/chat/chat.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  //---creat conversation loading index
  //--- assigning a dummy value
  int _loadingIndex = -1;

  //---get loading index
  int get loadingIndex => _loadingIndex;

  //---set loading index
  void setLoadingIndex([int i = -1]) {
    _loadingIndex = i;
    notifyListeners();
  }

  //---conversation model
  late ConversationModel _conversationModel;
  ConversationModel get conversationModel => _conversationModel;

  //--- set conversation model
  void setConversationModel(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

  //---start creating a conversation
  Future<void> startCreateConversation(
      BuildContext context, UserModel peeruser, int i) async {
    try {
      //---get the logged in user model
      UserModel me =
          Provider.of<userProvider>(context, listen: false).userModel!;

      //---start the loader
      setLoadingIndex(i);

      _conversationModel =
          await _chatController.createConversation(me, peeruser);
      notifyListeners();
      //---stop the loader
      setLoadingIndex();

      //---navigate the user to chat screen after creating the conversation
      // ignore: use_build_context_synchronously
      UtilFunctions.navigateTo(
          context,
          Chat(
            conId: _conversationModel.id,
          ));
    } catch (e) {
      //---stop the loader
      setLoadingIndex();
      Logger().e(e);
    }
  }

  //---- send message
  Future<void> startSendMessage(BuildContext context, String msg) async {
    try {
      //---get the logged in user model
      UserModel me =
          Provider.of<userProvider>(context, listen: false).userModel!;

      //---save message in db
      await _chatController.sendMessage(
        _conversationModel.id,
        me.firstName,
        me.uid,
        _peerUser.uid,
        msg,
        _peerUser.token,
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  //---peer user model
  late UserModel _peerUser;
  UserModel get peerUser => _peerUser;

  void setPeerUser(UserModel model) {
    _peerUser = model;
  }

  //---conversation list
  List<ConversationModel> _convList = [];
  List<ConversationModel> get convList => _convList;

  void setConvList(List<ConversationModel> list) {
    _convList = list;
  }

  //--- set Conversation Model and send user to chat screen when notification is click
  void setNotificationData(BuildContext context, String id) {
    try {
      //---find and set Conversation Model
      ConversationModel temp = _convList.firstWhere((e) => e.id == id);
      setConversationModel(temp);

      //---navigate the user to chat screen
      UtilFunctions.navigateTo(context, Chat(conId: id));
    } catch (e) {
      Logger().e(e);
    }
  }
}
