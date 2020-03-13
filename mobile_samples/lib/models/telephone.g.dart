// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telephone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Telephone _$TelephoneFromJson(Map<String, dynamic> json) {
  return Telephone()
    ..verified = json['verified'] as String
    ..contactType = json['contactType'] as String
    ..contactNumber = json['contactNumber'] as String
    ..areaCode = json['areaCode'] as String
    ..countryCode = json['countryCode'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$TelephoneToJson(Telephone instance) => <String, dynamic>{
      'verified': instance.verified,
      'contactType': instance.contactType,
      'contactNumber': instance.contactNumber,
      'areaCode': instance.areaCode,
      'countryCode': instance.countryCode,
      'id': instance.id
    };
