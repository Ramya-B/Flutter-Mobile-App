// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resend _$ResendFromJson(Map<String, dynamic> json) {
  return Resend()
    ..currentUserLoginId = json['currentUserLoginId'] as String
    ..newUserLoginId = json['newUserLoginId'] as String
    ..isPwdChange = json['isPwdChange'] as bool
    ..sendConfirmationDto = json['sendConfirmationDto'] == null
        ? null
        : SendConfirmationDto.fromJson(
            json['sendConfirmationDto'] as Map<String, dynamic>)
    ..firstName = json['firstName'] as String
    ..visitedregion = json['visitedregion'] as String;
}

Map<String, dynamic> _$ResendToJson(Resend instance) => <String, dynamic>{
      'currentUserLoginId': instance.currentUserLoginId,
      'newUserLoginId': instance.newUserLoginId,
      'isPwdChange': instance.isPwdChange,
      'sendConfirmationDto': instance.sendConfirmationDto,
      'firstName': instance.firstName,
      'visitedregion': instance.visitedregion
    };
