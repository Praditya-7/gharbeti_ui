import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String? from;
  final String? to;
  final String? title;
  String? documentId;
  final String? body;
  final Timestamp? time;
  final String? status;
  final String? month;

  Notifications({
    this.from,
    this.to,
    this.title,
    this.body,
    this.time,
    this.status,
    this.month,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      from: json['From'],
      to: json['To'],
      title: json['Title'],
      body: json['Body'],
      time: json['Time'],
      status: json['Status'],
      month: json['Month'],
    );
  }

  Notifications.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        from = snap.get('From'),
        to = snap.get('To'),
        title = snap.get('Title'),
        body = snap.get('Body'),
        time = snap.get('Time'),
        status = snap.get('Status'),
        month = snap.get('Month');

  toJson() {
    return {
      'From': from,
      'To': to,
      'Title': title,
      'Body': body,
      'Time': time,
      'Status': status,
      'Month': month,
    };
  }
}
