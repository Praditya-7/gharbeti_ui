import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? date;
  String? documentId;
  final String? message;
  final String? email;

  ChatModel({
    this.date,
    this.message,
    this.documentId,
    this.email,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      date: json['createdAt'],
      message: json['message'],
      email: json['senderEmail'],
    );
  }

  ChatModel.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        date = snap.get('createdAt'),
        message = snap.get('message'),
        email = snap.get('senderEmail');

  toJson() {
    return {
      'createdAt': date,
      'message': message,
      'senderEmail': email,
    };
  }
}
