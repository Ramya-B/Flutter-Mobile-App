// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uomDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UomDTO _$UomDTOFromJson(Map<String, dynamic> json) {
  return UomDTO()
    ..unit = json['unit'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$UomDTOToJson(UomDTO instance) => <String, dynamic>{
      'unit': instance.unit,
      'description': instance.description
    };
