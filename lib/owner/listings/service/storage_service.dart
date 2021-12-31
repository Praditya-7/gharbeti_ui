import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage({required this.listingNo});

  final String? listingNo;
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(String? files, String fileName) async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    try {
      await storage.ref('$email/$listingNo/$fileName').putFile(File(files!));
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> uploadPDF(File file, String randomFileName) async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    try {
      await storage.ref('Billings/$email/$randomFileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");

    firebase_storage.ListResult results = await storage.ref('$email/$listingNo/').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    return results;
  }

  Future<String> downloadImageURL(String imageName) async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    String downloadURL = await storage.ref('$email/$listingNo/$imageName').getDownloadURL();
    return downloadURL;
  }

  Future<String> downloadPDFURL(String fileName) async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    String downloadURL = await storage.ref('Billings/$email/$fileName').getDownloadURL();
    return downloadURL;
  }
}
