// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changePassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassword _$ChangePasswordFromJson(Map<String, dynamic> json) {
  return ChangePassword()
    ..userLoginId = json['userLoginId'] as String
    ..confirmationCode = json['confirmationCode'] as String
    ..currentPassword = json['currentPassword'] as String
    ..newPassword = json['newPassword'] as String
    ..firstName = json['firstName'] as String;
}

Map<String, dynamic> _$ChangePasswordToJson(ChangePassword instance) =>
    <String, dynamic>{
      'userLoginId': instance.userLoginId,
      'confirmationCode': instance.confirmationCode,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'firstName': instance.firstName
    };
