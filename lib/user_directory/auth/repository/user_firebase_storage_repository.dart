import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userFirebaseStorageRepositoryProvider = Provider((ref) {
  return UserFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  );
});

class UserFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  UserFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
