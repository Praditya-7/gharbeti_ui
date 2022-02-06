import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String? from;
  final String? to;
  final String? title;
  String? documentId;
  final String? body;
  final Timestamp? time;

  Notifications({
    this.from,
    this.to,
    this.title,
    this.body,
    this.time,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      from: json['From'],
      to: json['To'],
      title: json['Title'],
      body: json['Body'],
      time: json['Time'],
    );
  }

  Notifications.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        from = snap.get('From'),
        to = snap.get('To'),
        title = snap.get('Title'),
        body = snap.get('Body'),
        time = snap.get('Time');

  toJson() {
    return {
      'From': from,
      'To': to,
      'Title': title,
      'Body': body,
      'Time': time,
    };
  }
}
