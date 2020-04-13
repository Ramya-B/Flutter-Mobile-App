// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationNumbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationNumbers _$IdentificationNumbersFromJson(
    Map<String, dynamic> json) {
  return IdentificationNumbers()
    ..identificationAttributesList = (json['identificationAttributesList']
            as List)
        ?.map((e) => e == null
            ? null
            : IdentificationAttributesList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IdentificationNumbersToJson(
        IdentificationNumbers instance) =>
    <String, dynamic>{
      'identificationAttributesList': instance.identificationAttributesList
    };
