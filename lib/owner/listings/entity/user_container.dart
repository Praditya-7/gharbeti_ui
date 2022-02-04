import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? dob;
  final String? password;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? type;
  final String? gender;
  String? documentId;
  String? roomName;
  bool? isSelected = false;
  final String? pdfLink;
  final String? fileName;

  User({
    this.dob,
    this.password,
    this.email,
    this.name,
    this.roomName,
    this.phoneNumber,
    this.type,
    this.gender,
    this.pdfLink,
    this.fileName,
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
      gender: json['Gender'],
      fileName: json['FileName'],
      pdfLink: json['PDFLink'],
    );
  }

  User.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        dob = snap.get('Date of Birth'),
        roomName = snap.get('Room Name'),
        email = snap.get('Email'),
        password = snap.get('Password'),
        name = snap.get('Name'),
        gender = snap.get('Gender'),
        phoneNumber = snap.get('Phone Number'),
        pdfLink = snap.get('PDFLink'),
        fileName = snap.get('FileName'),
        type = snap.get('Type');

  toJson() {
    return {
      'Date of Birth': dob,
      'Email': email,
      'Room Name': roomName,
      'Password': password,
      'Gender': gender,
      'Phone Number': phoneNumber,
      'Name': name,
      'PDFLink': pdfLink,
      'FileName': fileName,
      'Type': type,
    };
  }
}
