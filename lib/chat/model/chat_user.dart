import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gharbeti_ui/chat/model/chat_model.dart';

import 'chat_model.dart';

class ChatUser {
  final String? participant;
  final List<ChatModel>? chatList;
  String? documentId;
  String? name;

  ChatUser({
    this.participant,
    this.chatList,
    this.documentId,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    var list = json['messageData'] as List;
    List<ChatModel> dataList =
        list.isEmpty ? [] : list.map((i) => ChatModel.fromJson(i)).toList();

    return ChatUser(
      participant: json['participants'],
      chatList: dataList,
    );
  }

  factory ChatUser.fromFireStoreSnapshot(DocumentSnapshot snap) {
    var dataList = snap.get('messageData');
    List<ChatModel> chatList = [];
    for (var doc in dataList) {
      chatList.add(ChatModel.fromJson(doc));
    }
    return ChatUser(
        documentId: snap.id,
        participant: snap.get('participants'),
        chatList: chatList);
  }

  toJson() {
    return {
      'participants': participant,
      'messageData': chatList,
    };
  }
}
