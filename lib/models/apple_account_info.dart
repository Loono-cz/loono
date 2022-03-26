import 'package:freezed_annotation/freezed_annotation.dart';

part 'apple_account_info.freezed.dart';
part 'apple_account_info.g.dart';

@freezed
class AppleAccountInfo with _$AppleAccountInfo {
  const factory AppleAccountInfo({
    required String userIdentifier,
    required String email,
    required String? givenName,
    required String? familyName,
  }) = _AppleAccountInfo;

  factory AppleAccountInfo.fromJson(Map<String, dynamic> json) => _$AppleAccountInfoFromJson(json);
}
