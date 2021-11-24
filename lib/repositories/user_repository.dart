import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/achievement.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/firebase_storage_service.dart';
import 'package:uuid/uuid.dart';

// TODO: Connect with ApiService
class UserRepository {
  UserRepository({
    required DatabaseService databaseService,
    required FirebaseStorageService firebaseStorageService,
  })  : _db = databaseService,
        _firebaseStorageService = firebaseStorageService;

  final DatabaseService _db;
  final FirebaseStorageService _firebaseStorageService;

  Future<void> createUser() async {
    await _db.users.deleteAll();
    await _db.users.upsert(User(id: const Uuid().v4()));
  }

  Future<void> updateCurrentUser(UsersCompanion usersCompanion) async {
    await _db.users.updateCurrentUser(usersCompanion);
  }

  Future<void> updateSex(Sex sex) async {
    await _db.users.updateSex(sex);
  }

  Future<void> updateDateOfBirth(DateWithoutDay dateWithoutDay) async {
    await _db.users.updateDateOfBirth(dateWithoutDay);
  }

  Future<void> updateGeneralPracticionerCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await _db.users.updateGeneralPracticionerCcaVisit(ccaDoctorVisit);
  }

  Future<void> updateGeneralPracticionerVisitDate(DateWithoutDay dateWithoutDay) async {
    await _db.users.updateGeneralPracticionerVisitDate(dateWithoutDay);
  }

  Future<void> updateGynecologyCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await _db.users.updateGynecologyCcaVisit(ccaDoctorVisit);
  }

  Future<void> updateGynecologyVisitDate(DateWithoutDay dateWithoutDay) async {
    await _db.users.updateGynecologyVisitDate(dateWithoutDay);
  }

  Future<void> updateDentistCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await _db.users.updateDentistCcaVisit(ccaDoctorVisit);
  }

  Future<void> updateDentistVisitDate(DateWithoutDay dateWithoutDay) async {
    await _db.users.updateDentistVisitDate(dateWithoutDay);
  }

  Future<void> updateNickname(String nickname) async {
    await _db.users.updateNickname(nickname);
  }

  Future<void> updateEmail(String email) async {
    await _db.users.updateEmail(email);
  }

  Future<void> updateAchievementCollection(Achievement achievement) async {
    await _db.users.updateAchievementCollection(achievement);
  }

  // TODO: Error handling
  // TODO: Compress the image before uploading
  /// Updates user's avatar.
  ///
  /// If the user already has an avatar, the current one will be replaced and
  /// updated with the new one.
  ///
  /// Returns `true` if the operation was successful.
  Future<bool?> updateUserPhoto(Uint8List imageBytes) async {
    final downloadUrl = await _firebaseStorageService.uploadData(
      imageBytes,
      ref: await _firebaseStorageService.userPhotoRef,
      settableMetadata: SettableMetadata(contentType: 'image/png'),
    );
    await _db.users.updateProfileImageUrl(downloadUrl);
    if (downloadUrl != null) return true;
  }

  /// Deletes user's avatar.
  ///
  /// Returns `true` if the operation was successful.
  Future<bool?> deleteUserPhoto() async {
    final result = await _firebaseStorageService.deleteData(
      ref: await _firebaseStorageService.userPhotoRef,
    );
    if (result == true) {
      await _db.users.updateProfileImageUrl(null);
    }
    return result;
  }
}
