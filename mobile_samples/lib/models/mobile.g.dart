// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mobile _$MobileFromJson(Map<String, dynamic> json) {
  return Mobile()
    ..id = json['id'] as String
    ..countryCode = json['countryCode'] as String
    ..areaCode = json['areaCode'] as String
    ..contactNumber = json['contactNumber'] as String
    ..contactType = json['contactType'] as String
    ..verified = json['verified'] as String;
}

Map<String, dynamic> _$MobileToJson(Mobile instance) => <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'areaCode': instance.areaCode,
      'contactNumber': instance.contactNumber,
      'contactType': instance.contactType,
      'verified': instance.verified
    };
