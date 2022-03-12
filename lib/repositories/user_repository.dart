import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:drift/drift.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/firebase_storage_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono_api/loono_api.dart';

class UserRepository {
  UserRepository({
    required ApiService apiService,
    required DatabaseService databaseService,
    required FirebaseStorageService firebaseStorageService,
    required AuthService authService,
    required NotificationService notificationService,
  })  : _apiService = apiService,
        _authService = authService,
        _db = databaseService,
        _firebaseStorageService = firebaseStorageService {
    _authService.onAuthStateChanged.listen((authUser) async {
      if (authUser != null) {
        debugPrint('log: SYNCING WITH API');
        await _authService.refreshUserToken();
        unawaited(sync());
        unawaited(notificationService.setUserId(authUser.uid));
      }
    });
  }

  final ApiService _apiService;
  final AuthService _authService;
  final DatabaseService _db;
  final FirebaseStorageService _firebaseStorageService;

  Future<void> sync() async {
    final account = await _apiService.getAccount();
    await account.whenOrNull(
      success: (data) async {
        await updateCurrentUserFromAccount(data);
      },
    );
  }

  Future<void> updateCurrentUserFromAccount(Account data) async {
    await _db.users.updateCurrentUser(
      UsersCompanion(
        nickname: Value<String>(data.nickname),
        dateOfBirth: Value<DateWithoutDay>(
          DateWithoutDay(
            year: data.birthdate.year,
            month: monthFromInt(data.birthdate.month),
          ),
        ),
        sex: Value<Sex>(data.sex),
        email: Value<String>(data.prefferedEmail),
        profileImageUrl: Value<String?>(data.profileImageUrl),
        points: Value<int>(data.points),
        badges: Value<BuiltList<Badge>>(data.badges),
      ),
    );
  }

  Future<void> createUser() async {
    await _db.users.deleteAll();
    await _db.users.insert(UsersCompanion.insert());
  }

  Future<void> createUserIfNotExists() async {
    final users = await _db.users.getUser();
    if (users.isEmpty) {
      await createUser();
    }
  }

  Future<void> updateCurrentUser(UsersCompanion usersCompanion) async {
    await _db.users.updateCurrentUser(usersCompanion);
  }

  Future<void> updateSex(Sex sex) async {
    await _db.users.updateCurrentUser(UsersCompanion(sex: Value<Sex>(sex)));
  }

  Future<void> updateDateOfBirth(DateWithoutDay dateWithoutDay) async {
    await _db.users.updateCurrentUser(
      UsersCompanion(dateOfBirth: Value<DateWithoutDay>(dateWithoutDay)),
    );
  }

  Future<void> updateDeviceCalendarId(String id) async {
    await _db.users.updateCurrentUser(UsersCompanion(defaultDeviceCalendarId: Value<String>(id)));
  }

  Future<bool> deleteAccount() async {
    final apiResponse = await _apiService.deleteAccount();
    return apiResponse.map(
      success: (_) async {
        return true;
      },
      failure: (_) async {
        return false;
      },
    );
  }

  Future<bool> updateNickname(String nickname) async {
    final apiResponse = await _apiService.updateAccountUser(nickname: nickname);
    final result = await apiResponse.map(
      success: (_) async {
        await _db.users.updateCurrentUser(UsersCompanion(nickname: Value(nickname)));
        return true;
      },
      failure: (_) async => false,
    );
    return result;
  }

  Future<bool> updateEmail(String email) async {
    final apiResponse = await _apiService.updateAccountUser(prefferedEmail: email);
    final result = await apiResponse.map(
      success: (_) async {
        await _db.users.updateCurrentUser(UsersCompanion(email: Value(email)));
        return true;
      },
      failure: (_) async => false,
    );
    return result;
  }

  // TODO: Error handling (https://cesko-digital.atlassian.net/browse/LOON-386)
  // TODO: Compress the image before uploading (https://cesko-digital.atlassian.net/browse/LOON-368)
  /// Updates user's avatar.
  ///
  /// If the user already has an avatar, the current one will be replaced and
  /// updated with the new one.
  ///
  /// Returns `true` if the operation was successful.
  Future<bool> updateUserPhoto(Uint8List imageBytes) async {
    final downloadUrl = await _firebaseStorageService.uploadData(
      imageBytes,
      ref: await _firebaseStorageService.userPhotoRef,
      settableMetadata: SettableMetadata(contentType: 'image/png'),
    );
    if (downloadUrl != null) {
      final apiResponse = await _apiService.updateAccountUser(profileImageUrl: downloadUrl);
      final result = await apiResponse.map(
        success: (_) async {
          await _db.users.updateCurrentUser(UsersCompanion(profileImageUrl: Value(downloadUrl)));
          return true;
        },
        failure: (_) async => false,
      );
      return result;
    }
    return false;
  }

  /// Deletes user's avatar.
  ///
  /// Returns `true` if the operation was successful.
  Future<bool> deleteUserPhoto() async {
    final result = await _firebaseStorageService.deleteData(
      ref: await _firebaseStorageService.userPhotoRef,
    );
    if (result == true) {
      final apiResponse = await _apiService.updateAccountUser(profileImageUrl: null);
      final result = await apiResponse.map(
        success: (_) async {
          await _db.users.updateCurrentUser(const UsersCompanion(profileImageUrl: Value(null)));
          return true;
        },
        failure: (_) async => false,
      );
      return result;
    }
    return false;
  }
}
