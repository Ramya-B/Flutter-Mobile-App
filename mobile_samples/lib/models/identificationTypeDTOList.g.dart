// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationTypeDTOList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationTypeDTOList _$IdentificationTypeDTOListFromJson(
    Map<String, dynamic> json) {
  return IdentificationTypeDTOList()
    ..identificationTypeId = json['identificationTypeId'] as String
    ..identificationTypeName = json['identificationTypeName'] as String
    ..attributeName = json['attributeName'] as String
    ..attributeType = json['attributeType'] as String
    ..attributeValue = json['attributeValue'] as String
    ..identificationFieldsList = (json['identificationFieldsList'] as List)
        ?.map((e) => e == null
            ? null
            : IdentificationFieldsList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..identificationGroupId = json['identificationGroupId'] as String
    ..attributeNameWithOutBucketName =
        json['attributeNameWithOutBucketName'] as String;
}

Map<String, dynamic> _$IdentificationTypeDTOListToJson(
        IdentificationTypeDTOList instance) =>
    <String, dynamic>{
      'identificationTypeId': instance.identificationTypeId,
      'identificationTypeName': instance.identificationTypeName,
      'attributeName': instance.attributeName,
      'attributeType': instance.attributeType,
      'attributeValue': instance.attributeValue,
      'identificationFieldsList': instance.identificationFieldsList,
      'identificationGroupId': instance.identificationGroupId,
      'attributeNameWithOutBucketName': instance.attributeNameWithOutBucketName
    };
