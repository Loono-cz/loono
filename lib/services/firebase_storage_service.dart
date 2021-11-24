import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:moor/moor.dart';

class FirebaseStorageService {
  FirebaseStorageService({
    required AuthService authService,
  })  : _authService = authService,
        _storage = FirebaseStorage.instance;

  final AuthService _authService;
  final FirebaseStorage _storage;

  /// Returns [Reference] location of the user's avatar.
  Future<Reference?> getUserPhotoRef() async {
    final uid = await _authService.userUid;
    if (uid == null) return null;
    return _storage.ref().child('users').child(uid).child('files').child('avatar.png');
  }

  // TODO: Error handling
  /// Uploads data in the form of bytes to Firebase Storage to the referenced [ref] location.
  ///
  /// If the file already exists in the [ref] location, the current one will be replaced and
  /// updated with the new one.
  ///
  /// Returns download URL of the uploaded file.
  Future<String?> uploadData(
    Uint8List bytesData, {
    required Reference? ref,
    SettableMetadata? settableMetadata,
  }) async {
    if (ref == null) return null;
    final uploadTask = ref.putData(bytesData, settableMetadata);
    final TaskSnapshot taskSnapshot;
    try {
      taskSnapshot = await uploadTask;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // TODO: Error messaging
  /// Deletes data at the [ref] location.
  Future<bool?> deleteData({required Reference? ref}) async {
    if (ref == null) return null;
    await ref.delete();
    return true;
  }
}
