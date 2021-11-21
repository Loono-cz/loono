import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:moor/moor.dart';

// TODO: Upload profile photo url also to Loono BE
class FirebaseStorageRepository {
  FirebaseStorageRepository({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _storage = FirebaseStorage.instance,
        _userRepository = userRepository;

  final AuthService _authService;
  final FirebaseStorage _storage;
  final UserRepository _userRepository;

  Future<String?> get userUid async {
    final user = await _authService.getCurrentUser();
    return user?.uid;
  }

  Reference getUserPhotoRef(String uid) =>
      _storage.ref().child('users').child(uid).child('files').child('avatar.png');

  // TODO: Error handling
  // TODO: Compress the image before uploading
  // TODO: Check the image size before uploading (should be <10 MB)
  /// This will upload the user's picked avatar to Firebase Storage.
  ///
  /// If the user already has an avatar, the current one will be replaced and
  /// updated with the new one.
  Future<String?> uploadUserPhoto(Uint8List imageBytes) async {
    final uid = await userUid;
    if (uid == null) return null;
    final ref = getUserPhotoRef(uid);
    final uploadTask = ref.putData(imageBytes, SettableMetadata(contentType: 'image/png'));
    final TaskSnapshot taskSnapshot;
    try {
      taskSnapshot = await uploadTask;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await _userRepository.updateProfileImageUrl(downloadUrl);
    return downloadUrl;
  }

  // TODO: Error messaging
  Future<bool?> deleteUserPhoto() async {
    final uid = await userUid;
    if (uid == null) return false;
    await getUserPhotoRef(uid).delete();
    await _userRepository.updateProfileImageUrl(null);
    return true;
  }
}
