import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String? bathroom;
  final String? description;
  final String? floor;
  final String? internet;
  final String? kitchen;
  final String? listingNo;
  final String? rent;
  final String? parking;
  final String? preferences;
  final String? negotiable;
  final String? status;
  final String? type;
  final String? email;
  String? documentId;
  final String? tenantEmail;
  final double latitude;
  final double longitude;
  final String? lastMeterReading;
  final List<String>? imagesLinkList;

  Room({
    this.negotiable,
    this.bathroom,
    this.description,
    this.floor,
    this.internet,
    this.kitchen,
    this.listingNo,
    this.rent,
    this.parking,
    this.preferences,
    this.status,
    this.type,
    this.email,
    this.tenantEmail,
    this.lastMeterReading,
    this.imagesLinkList,
    required this.latitude,
    required this.longitude,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    var list = json['ImageLinkList'] as List;
    List<String> dataList = List<String>.from(list);
    return Room(
      bathroom: json['Bathrooms'],
      description: json['Description'],
      floor: json['Floor'],
      internet: json['Internet'],
      kitchen: json['Kitchen'],
      listingNo: json['ListingNo'],
      rent: json['MonthlyRent'],
      parking: json['Parking'],
      preferences: json['Preferences'],
      status: json['Status'],
      type: json['Type'],
      tenantEmail: json['Tenant Email'],
      email: json['OwnerEmail'],
      negotiable: json['Negotiable'],
      latitude: json['Latitude'],
      lastMeterReading: json['LastMeterReading'],
      longitude: json['Longitude'],
      imagesLinkList: dataList,
    );
  }

  Room.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        bathroom = snap.get('Bathrooms'),
        description = snap.get('Description'),
        floor = snap.get('Floor'),
        internet = snap.get('Internet'),
        kitchen = snap.get('Kitchen'),
        listingNo = snap.get('ListingNo'),
        rent = snap.get('Rent'),
        parking = snap.get('Parking'),
        preferences = snap.get('Preferences'),
        type = snap.get('Type'),
        status = snap.get('Status'),
        negotiable = snap.get('Negotiable'),
        tenantEmail = snap.get('Tenant Email'),
        latitude = snap.get('Latitude'),
        longitude = snap.get('Longitude'),
        imagesLinkList = List<String>.from(snap.get('ImageLinkList')),
        lastMeterReading = snap.get('LastMeterReading'),
        email = snap.get('OwnerEmail');

  toJson() {
    return {
      'Bathrooms': bathroom,
      'Description': description,
      'Floor': floor,
      'Internet': internet,
      'Kitchen': kitchen,
      'ListingNo': listingNo,
      'Rent': rent,
      'Parking': parking,
      'Tenant Email': tenantEmail,
      'Preferences': preferences,
      'Type': type,
      'Status': status,
      'OwnerEmail': email,
      'Negotiable': negotiable,
      'Latitude': latitude,
      'Longitude': longitude,
      'LastMeterReading': lastMeterReading,
      'ImageLinkList': imagesLinkList,
    };
  }
}
