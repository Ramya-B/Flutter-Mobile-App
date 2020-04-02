// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileAttribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileAttribute _$ProfileAttributeFromJson(Map<String, dynamic> json) {
  return ProfileAttribute()
    ..attributeId = json['attributeId'] as String
    ..attrName = json['attrName'] as String
    ..attrValue = json['attrValue'] as String
    ..attrType = json['attrType'] as String
    ..attributeNameForES = json['attributeNameForES'] as String;
}

Map<String, dynamic> _$ProfileAttributeToJson(ProfileAttribute instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
      'attrName': instance.attrName,
      'attrValue': instance.attrValue,
      'attrType': instance.attrType,
      'attributeNameForES': instance.attributeNameForES
    };
