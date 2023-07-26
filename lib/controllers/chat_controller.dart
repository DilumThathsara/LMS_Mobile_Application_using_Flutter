import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/models/objects.dart';

class ChatController {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //---retrive and listen to user collection in realtime using a stream
  Stream<QuerySnapshot> getUsers(String currentUserId) =>
      users.where('uid', isNotEqualTo: currentUserId).snapshots();

  //--- create conversation
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  //---create conversation on the db
  Future<ConversationModel> createConversation(
      UserModel me, UserModel peeruser) async {
    //---check if the convacation exists first
    ConversationModel? model = await checkConvExist(me.uid, peeruser.uid);

    if (model == null) {
      //---get an uniqe document id
      String docid = conversations.doc().id;

      await conversations
          .doc(docid)
          .set({
            'id': docid,
            'users': [me.uid, peeruser.uid],

            ///--- to filter conversation via sream
            'usersArray': [me.toJson(), peeruser.toJson()],
            'lastMessage': "started a conversation",
            'lastMessageTime': DateTime.now().toString(),
            'createdBy': me.uid,
            'createdAt': DateTime.now(),
          })
          .then((value) => Logger().i("Conversation Saved"))
          .catchError(
            (error) => Logger().i("Failed to update: $error"),
          );

      DocumentSnapshot snapshot = await conversations.doc(docid).get();

      return ConversationModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
    } else {
      return model;
    }
  }

  //---check if the createing convercation already exists in the db
  Future<ConversationModel?> checkConvExist(String myId, String peerId) async {
    try {
      ConversationModel? conModel;
      //---first check in the db for match convercation with the given userid list
      QuerySnapshot result = await conversations
          .where('users', arrayContainsAny: [myId, peerId]).get();

      Logger().w(result.docs.length);

      //----check in the fetch result
      for (var item in result.docs) {
        //---first mapping the single document data to the convercation model
        var model =
            ConversationModel.fromJson(item.data() as Map<String, dynamic>);

        //---then check
        if (model.users.contains(myId) && model.users.contains(peerId)) {
          Logger().w("the conversation is already exists");
          conModel = model;
          return conModel;
        } else {
          Logger().w("the conversation is already not exists");
          conModel = null;
        }
      }
      return conModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //---retive convercation stream
  Stream<QuerySnapshot> getConversations(String currentUserId) => conversations
      .orderBy('createdAt', descending: true)
      .where('users', arrayContainsAny: [currentUserId]).snapshots();

  //---send messages
  CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(
    String conId,
    String senderName,
    String senderId,
    String reciverId,
    String message,
    String reciverToken,
  ) async {
    try {
      //---save a message in db
      await messageCollection.add({
        "conId": conId,
        "senderName": senderName,
        "senderId": senderId,
        "reciverId": reciverId,
        "message": message,
        "messageTime": DateTime.now().toString(),
        "reciverToken": reciverToken,
        'createdAt': DateTime.now(),
      });

      //----update the conversation last message and time
      await conversations.doc(conId).update({
        'lastMessage': message,
        'lastMessageTime': DateTime.now().toString(),
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //---retive message by conversation id stream
  Stream<QuerySnapshot> getMessages(String conId) => messageCollection
      .orderBy('createdAt', descending: true)
      .where('conId', isEqualTo: conId)
      .snapshots();

  //---listen to peer user uid
  Stream<DocumentSnapshot> getPeerUserOnlineStatus(String uid) =>
      users.doc(uid).snapshots();
}
