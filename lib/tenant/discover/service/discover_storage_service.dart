import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiscoverStorage {
  DiscoverStorage({required this.listingNo, required this.email});

  final String? listingNo;
  final String? email;
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('$email/$listingNo/$imageName').getDownloadURL();
    return downloadURL;
  }
}
