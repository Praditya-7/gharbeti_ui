import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? dob;
  final String? password;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? type;
  String? documentId;
  String? roomName;
  bool? isSelected = false;

  User({
    this.dob,
    this.password,
    this.email,
    this.name,
    this.roomName,
    this.phoneNumber,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      dob: json['Date of Birth'],
      roomName: json['Room Name'],
      email: json['Email'],
      password: json['Password'],
      name: json['Name'],
      phoneNumber: json['Phone Number'],
      type: json['Type'],
    );
  }

  User.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        dob = snap.get('Date of Birth'),
        roomName = snap.get('Room Name'),
        email = snap.get('Email'),
        password = snap.get('Password'),
        name = snap.get('Name'),
        phoneNumber = snap.get('Phone Number'),
        type = snap.get('Type');

  toJson() {
    return {
      'Date of Birth': dob,
      'Email': email,
      'Room Name': roomName,
      'Password': password,
      'Phone Number': phoneNumber,
      'Name': name,
      'Type': type,
    };
  }
}
