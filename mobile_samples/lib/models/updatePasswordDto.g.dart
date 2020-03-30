// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updatePasswordDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordDto _$UpdatePasswordDtoFromJson(Map<String, dynamic> json) {
  return UpdatePasswordDto()
    ..userLoginId = json['userLoginId'] as String
    ..currentPassword = json['currentPassword'] as String
    ..newPassword = json['newPassword'] as String;
}

Map<String, dynamic> _$UpdatePasswordDtoToJson(UpdatePasswordDto instance) =>
    <String, dynamic>{
      'userLoginId': instance.userLoginId,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword
    };
