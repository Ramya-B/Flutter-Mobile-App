// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email()
    ..verified = json['verified'] as String
    ..emailType = json['emailType'] as String
    ..emailAddress = json['emailAddress'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'verified': instance.verified,
      'emailType': instance.emailType,
      'emailAddress': instance.emailAddress,
      'id': instance.id
    };
