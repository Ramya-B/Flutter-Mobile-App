// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IdentityNumberAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityNumberAttributes _$IdentityNumberAttributesFromJson(
    Map<String, dynamic> json) {
  return IdentityNumberAttributes()
    ..identificationAttributesList = (json['identificationAttributesList']
            as List)
        ?.map((e) => e == null
            ? null
            : IdentificationAttributesList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IdentityNumberAttributesToJson(
        IdentityNumberAttributes instance) =>
    <String, dynamic>{
      'identificationAttributesList': instance.identificationAttributesList
    };
