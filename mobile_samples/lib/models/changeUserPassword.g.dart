// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changeUserPassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeUserPassword _$ChangeUserPasswordFromJson(Map<String, dynamic> json) {
  return ChangeUserPassword()
    ..userLoginId = json['userLoginId'] as String
    ..confirmationCode = json['confirmationCode'] as String
    ..currentPassword = json['currentPassword'] as String
    ..newPassword = json['newPassword'] as String
    ..firstName = json['firstName'] as String;
}

Map<String, dynamic> _$ChangeUserPasswordToJson(ChangeUserPassword instance) =>
    <String, dynamic>{
      'userLoginId': instance.userLoginId,
      'confirmationCode': instance.confirmationCode,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'firstName': instance.firstName
    };
