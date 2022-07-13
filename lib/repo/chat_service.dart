import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/constants/data_keys.dart';
import 'package:untitled1/data/chat_model.dart';
import 'package:untitled1/data/chatroom_model.dart';

// service는 api를 연결하는 도구
class ChatService {
  static final ChatService _chatService = ChatService._internal();
  factory ChatService() => _chatService;
  ChatService._internal();

  Future createNewChatroom(ChatroomModel chatroomModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(
            ChatroomModel.generateChatRoomKey(
                chatroomModel.buyerKey, chatroomModel.itemKey));
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(chatroomModel.toJson());
    }
  }

  Future createNewChat(String chatroomKey, ChatModel chatModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection(COL_CHATROOMS)
            .doc(chatroomKey)
            .collection(COL_CHATS)
            .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey);

    await documentReference.set(chatModel.toJson());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatModel.toJson());
      transaction.update(chatroomDocRef, {
        DOC_LASTMSG: chatModel.msg,
        DOC_LASTMSGTIME: chatModel.createdDate,
        DOC_LASTMSGUSERKEY: chatModel.userKey
      });
    });
  }

  // stream을 통해 chatroommodel 받아오기
  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromSnapshot(snapshot);
    sink.add(chatroom);
  });

  // 마지막 채팅을 목록에 보이게 하기
  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .limit(10)
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  Future<List<ChatModel>> getLatestChats(
      String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .endBeforeDocument(await currentLatestChatRef.get())
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  Future<List<ChatModel>> getOlderChats(
      String chatroomKey, DocumentReference oldestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .startAfterDocument(await oldestChatRef.get())
        .limit(10)
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  // 채팅 리스트
  Future<List<ChatroomModel>> getMyChatList(String myUserkey) async {
    List<ChatroomModel> chatrooms = [];

    QuerySnapshot<Map<String, dynamic>> buying = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .where(DOC_BUYERKEY, isEqualTo: myUserkey)
        .get();

    QuerySnapshot<Map<String, dynamic>> selling = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .where(DOC_SELLERKEY, isEqualTo: myUserkey)
        .get();

    buying.docs.forEach((documentSnapshot) {
      chatrooms.add(ChatroomModel.fromQuerySnapshot(documentSnapshot));
    });
    selling.docs.forEach((documentSnapshot) {
      chatrooms.add(ChatroomModel.fromQuerySnapshot(documentSnapshot));
    });

    print('chatroom list - ${chatrooms.length}');

    // 최신 채팅창이 앞으로 오게
    chatrooms.sort((a, b) => (a.lastMsgTime).compareTo(b.lastMsgTime));

    return chatrooms;
  }
}
