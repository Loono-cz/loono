// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppleAccountInfo _$$_AppleAccountInfoFromJson(Map<String, dynamic> json) =>
    _$_AppleAccountInfo(
      userIdentifier: json['userIdentifier'] as String,
      email: json['email'] as String,
      givenName: json['givenName'] as String?,
      familyName: json['familyName'] as String?,
      identifierToken: json['identifierToken'] as String?,
    );

Map<String, dynamic> _$$_AppleAccountInfoToJson(_$_AppleAccountInfo instance) =>
    <String, dynamic>{
      'userIdentifier': instance.userIdentifier,
      'email': instance.email,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'identifierToken': instance.identifierToken,
    };
