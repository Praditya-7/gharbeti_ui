import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String? address;
  final String? bathroom;
  final String? city;
  final String? description;
  final String? floor;
  final String? internet;
  final String? kitchen;
  final String? listingNo;
  final String? rent;
  final String? parking;
  final String? preference;
  final String? state;
  final String? status;
  final String? type;
  final String? email;
  String? documentId;

  Room({
    this.address,
    this.bathroom,
    this.city,
    this.description,
    this.floor,
    this.internet,
    this.kitchen,
    this.listingNo,
    this.rent,
    this.parking,
    this.preference,
    this.state,
    this.status,
    this.type,
    this.email,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      address: json['Address'],
      bathroom: json['Bathrooms'],
      city: json['City'],
      description: json['Description'],
      floor: json['Floor'],
      internet: json['Internet'],
      kitchen: json['Kitchen'],
      listingNo: json['ListingNo'],
      rent: json['MonthlyRent'],
      parking: json['Parking'],
      preference: json['Preferences'],
      state: json['State'],
      status: json['Status'],
      type: json['Type'],
      email: json['OwnerEmail'],
    );
  }

  Room.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        address = snap.get('Address'),
        bathroom = snap.get('Bathrooms'),
        city = snap.get('City'),
        description = snap.get('Description'),
        floor = snap.get('Floor'),
        internet = snap.get('Internet'),
        kitchen = snap.get('Kitchen'),
        listingNo = snap.get('ListingNo'),
        rent = snap.get('MonthlyRent'),
        parking = snap.get('Parking'),
        preference = snap.get('Preferences'),
        state = snap.get('State'),
        type = snap.get('Type'),
        status = snap.get('Status'),
        email = snap.get('OwnerEmail');

  toJson() {
    return {
      'Address': address,
      'Bathrooms': bathroom,
      'City': city,
      'Description': description,
      'Floor': floor,
      'Internet': internet,
      'Kitchen': kitchen,
      'ListingNo': listingNo,
      'MonthlyRent': rent,
      'Parking': parking,
      'Preferences': preference,
      'State': state,
      'Type': type,
      'Status': status,
      'OwnerEmail': email,
    };
  }
}
