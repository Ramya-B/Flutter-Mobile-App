// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationAttributesList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationAttributesList _$IdentificationAttributesListFromJson(
    Map<String, dynamic> json) {
  return IdentificationAttributesList()
    ..attributeName = json['attributeName'] as String
    ..attributeType = json['attributeType'] as String
    ..attributeValidation = json['attributeValidation'] as String
    ..isRequired = json['isRequired'] as bool
    ..anyOneFilled = json['anyOneFilled'] as bool
    ..identificationTypeId = json['identificationTypeId'] as String
    ..identificationGroupId = json['identificationGroupId'] as String;
}

Map<String, dynamic> _$IdentificationAttributesListToJson(
        IdentificationAttributesList instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'attributeType': instance.attributeType,
      'attributeValidation': instance.attributeValidation,
      'isRequired': instance.isRequired,
      'anyOneFilled': instance.anyOneFilled,
      'identificationTypeId': instance.identificationTypeId,
      'identificationGroupId': instance.identificationGroupId
    };
