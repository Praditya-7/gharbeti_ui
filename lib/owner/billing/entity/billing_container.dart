import 'package:cloud_firestore/cloud_firestore.dart';

class Billings {
  final String? ownerEmail;
  final String? month;
  final int? remainingDues;
  final int? electricityPerUnitCharge;
  final int? lastMeterReading;
  final int? currentMeterReading;
  final String? status;
  final int? consumedUnit;
  final int? rent;
  final int? totalElectricityCost;
  final int? internetCharge;
  final int? waterCharge;
  String? documentId;
  final String? tenantEmail;
  final int? total;
  final String? pdfLink;
  final Timestamp? billDate;

  Billings({
    this.waterCharge,
    this.ownerEmail,
    this.month,
    this.remainingDues,
    this.electricityPerUnitCharge,
    this.lastMeterReading,
    this.currentMeterReading,
    this.rent,
    this.status,
    this.consumedUnit,
    this.totalElectricityCost,
    this.tenantEmail,
    this.total,
    this.pdfLink,
    this.internetCharge,
    this.billDate,
  });

  factory Billings.fromJson(Map<String, dynamic> json) {
    return Billings(
        ownerEmail: json['Bathrooms'],
        month: json['Description'],
        remainingDues: json['Floor'],
        electricityPerUnitCharge: json['Internet'],
        lastMeterReading: json['Kitchen'],
        status: json['Status'],
        currentMeterReading: json['ListingNo'],
        rent: json['MonthlyRent'],
        consumedUnit: json['Parking'],
        totalElectricityCost: json['Preferences'],
        tenantEmail: json['Tenant Email'],
        waterCharge: json['Negotiable'],
        total: json['TotalCost'],
        pdfLink: json['PDFLink'],
        billDate: json['BillDate'],
        internetCharge: json['InternetCharge']);
  }

  Billings.fromFireStoreSnapshot(DocumentSnapshot snap)
      : documentId = snap.id,
        ownerEmail = snap.get('OwnerEmail'),
        month = snap.get('Month'),
        remainingDues = snap.get('RemainingDues'),
        electricityPerUnitCharge = snap.get('ElectricityPerUnitCharge'),
        lastMeterReading = snap.get('LastMeterReading'),
        status = snap.get('Status'),
        currentMeterReading = snap.get('CurrentMeterReading'),
        rent = snap.get('Rent'),
        consumedUnit = snap.get('ConsumedUnit'),
        totalElectricityCost = snap.get('TotalElectricityCost'),
        waterCharge = snap.get('WaterCharge'),
        tenantEmail = snap.get('TenantEmail'),
        pdfLink = snap.get('PDFLink'),
        internetCharge = snap.get('InternetCharge'),
        billDate = snap.get('BillDate'),
        total = snap.get('TotalCost');
  toJson() {
    return {
      'OwnerEmail': ownerEmail,
      'Month': month,
      'RemainingDues': remainingDues,
      'ElectricityPerUnitCharge': electricityPerUnitCharge,
      'LastMeterReading': lastMeterReading,
      'CurrentMeterReading': currentMeterReading,
      'Rent': rent,
      'Status': status,
      'ConsumedUnit': consumedUnit,
      'TenantEmail': tenantEmail,
      'TotalElectricityCost': totalElectricityCost,
      'WaterCharge': waterCharge,
      'PDFLink': pdfLink,
      'InternetCharge': internetCharge,
      'BillDate': billDate,
      'TotalCost': total,
    };
  }
}
