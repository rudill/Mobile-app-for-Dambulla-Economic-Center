import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future<String> getImageUrl(String imageName) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('$imageName');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }
}
