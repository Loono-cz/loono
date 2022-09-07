// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DonateUserInfo _$$_DonateUserInfoFromJson(Map<String, dynamic> json) =>
    _$_DonateUserInfo(
      lastOpened: json['lastOpened'] == null
          ? null
          : DateTime.parse(json['lastOpened'] as String),
      seen: json['seen'] as bool?,
      showNotification: json['showNotification'] as bool?,
    );

Map<String, dynamic> _$$_DonateUserInfoToJson(_$_DonateUserInfo instance) =>
    <String, dynamic>{
      'lastOpened': instance.lastOpened?.toIso8601String(),
      'seen': instance.seen,
      'showNotification': instance.showNotification,
    };
