import 'package:freezed_annotation/freezed_annotation.dart';

part 'donate_user_info.freezed.dart';
part 'donate_user_info.g.dart';

@freezed
class DonateUserInfo with _$DonateUserInfo {
  const factory DonateUserInfo({
    required final DateTime lastOpened,
    required final bool showNotification,
  }) = _DonateUserInfo;

  factory DonateUserInfo.fromJson(Map<String, dynamic> json) => _$DonateUserInfoFromJson(json);
}
