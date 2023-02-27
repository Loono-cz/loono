import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/models/apple_account_info.dart';
import 'package:loono/models/donate_user_info.dart';

const _appleAccountsDataKey = 'appleAccountsData';
const _donateInfoDataKey = 'donateInfoData';
const _databasePassKey = 'databasePassword';

/// We do not want to delete these keys on logout/delete account because we need to access
/// them afterwards. These data are securely stored.
const _ignoredKeys = <String>[_appleAccountsDataKey, _donateInfoDataKey, _databasePassKey];

class SecureStorageService {
  const SecureStorageService({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _storage = flutterSecureStorage;

  final FlutterSecureStorage _storage;

  /// We are saving this specifically to persist the user email during the first Apple ID
  /// authorization.
  ///
  /// This email and other use details are only exposed on the **FIRST** authorization so for
  /// later logins we need to get it from the secured local storage by the **userIdentifier**.
  ///
  /// https://pub.dev/documentation/sign_in_with_apple_platform_interface/latest/authorization_credential/AuthorizationCredentialAppleID/email.html
  Future<void> saveAppleAccountInfo(AppleAccountInfo appleAccountInfo) async {
    final savedAccounts = await _getAllAppleAccountsData();
    final newAccounts = savedAccounts == null ? <AppleAccountInfo>[] : List.of(savedAccounts);
    final matchedAccount = newAccounts
        .firstWhereOrNull((acc) => acc.userIdentifier == appleAccountInfo.userIdentifier);
    if (matchedAccount == null) {
      // account with this ID is not saved yet
      newAccounts.add(appleAccountInfo);
    } else {
      // account with this ID is already saved
      return;
    }
    final serializedData = const AppleAccountInfoListJsonConverter().toJson(newAccounts);
    await _storage.write(key: _appleAccountsDataKey, value: serializedData);
  }

  Future<AppleAccountInfo?> getAppleAccountInfoById(String userIdentifier) async {
    final accounts = await _getAllAppleAccountsData();
    if (accounts == null) return null;
    final matchedAccount = accounts.firstWhereOrNull((acc) => acc.userIdentifier == userIdentifier);
    return matchedAccount;
  }

  Future<List<AppleAccountInfo>?> _getAllAppleAccountsData() async {
    final data = await _storage.read(key: _appleAccountsDataKey);
    if (data == null) return null;
    final accountsData = const AppleAccountInfoListJsonConverter().fromJson(data);
    return accountsData;
  }

  /// Delete all entries except [_ignoredKeys].
  Future<void> deleteAll() async {
    final keysToRemove = <String>[];
    final allStoredEntries = await _storage.readAll();
    for (final key in allStoredEntries.keys) {
      if (!_ignoredKeys.contains(key)) {
        keysToRemove.add(key);
      }
    }
    await Future.wait<void>(<Future<void>>[
      for (final k in keysToRemove) _storage.delete(key: k),
    ]);
  }

  Future<DonateUserInfo?> getDonateInfoData() async {
    final data = await _storage.read(key: _donateInfoDataKey);
    if (data == null) return null;
    final donateData = DonateUserInfo.fromJson(jsonDecode(data) as Map<String, dynamic>);
    return donateData;
  }

  Future<String?> storeDonateInfoData(DonateUserInfo donateInfo) async {
    await _storage.write(key: _donateInfoDataKey, value: jsonEncode(donateInfo.toJson()));
    final data = await getDonateInfoData();
    if (data == null) return null;
    if (data.lastOpened == donateInfo.lastOpened) return 'OK';
    return null;
  }

  Future<void> deleteDonateInfoData() => _storage.delete(key: _donateInfoDataKey);

  Future<void> generateDatabasePass() async {
    const passwordLength = 20;
    const charCount = 26;
    const upperCharASCIIcode = 65;
    const smallCharASCIIcode = 97;
    final r = Random.secure();
    var key = '';
    for (var i = 0; i < passwordLength; i++) {
      key += String.fromCharCode(
        r.nextBool()
            ? (r.nextInt(charCount) + upperCharASCIIcode)
            : (r.nextInt(charCount) + smallCharASCIIcode),
      );
    }
    await _storage.write(key: _databasePassKey, value: key);
  }

  Future<String?> getDatabasePass() async {
    final pass = await _storage.read(key: _databasePassKey);
    return pass;
  }

  Future<void> deleteDatabasePass() => _storage.delete(key: _databasePassKey);
}
