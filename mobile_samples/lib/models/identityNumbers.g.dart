// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identityNumbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityNumbers _$IdentityNumbersFromJson(Map<String, dynamic> json) {
  return IdentityNumbers()
    ..attributeName = json['attributeName'] as String
    ..attributeType = json['attributeType'] as String
    ..attributeValidation = json['attributeValidation'] as String
    ..isRequired = json['isRequired'] as bool
    ..anyOneFilled = json['anyOneFilled'] as bool
    ..identificationTypeId = json['identificationTypeId'] as String;
}

Map<String, dynamic> _$IdentityNumbersToJson(IdentityNumbers instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'attributeType': instance.attributeType,
      'attributeValidation': instance.attributeValidation,
      'isRequired': instance.isRequired,
      'anyOneFilled': instance.anyOneFilled,
      'identificationTypeId': instance.identificationTypeId
    };
