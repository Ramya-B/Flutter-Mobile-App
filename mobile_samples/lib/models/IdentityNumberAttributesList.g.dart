// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IdentityNumberAttributesList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityNumberAttributesList _$IdentityNumberAttributesListFromJson(
    Map<String, dynamic> json) {
  return IdentityNumberAttributesList()
    ..identificationAttributesList = (json['identificationAttributesList']
            as List)
        ?.map((e) => e == null
            ? null
            : IdentificationAttributesList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IdentityNumberAttributesListToJson(
        IdentityNumberAttributesList instance) =>
    <String, dynamic>{
      'identificationAttributesList': instance.identificationAttributesList
    };
