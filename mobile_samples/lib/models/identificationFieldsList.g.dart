// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationFieldsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationFieldsList _$IdentificationFieldsListFromJson(
    Map<String, dynamic> json) {
  return IdentificationFieldsList()
    ..name = json['name'] as String
    ..validation = json['validation'] as String
    ..type = json['type'] as String
    ..required = json['required'] as String
    ..verificationLink = json['verificationLink'] as String;
}

Map<String, dynamic> _$IdentificationFieldsListToJson(
        IdentificationFieldsList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'validation': instance.validation,
      'type': instance.type,
      'required': instance.required,
      'verificationLink': instance.verificationLink
    };
