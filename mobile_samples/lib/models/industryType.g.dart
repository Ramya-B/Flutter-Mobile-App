// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industryType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndustryType _$IndustryTypeFromJson(Map<String, dynamic> json) {
  return IndustryType()
    ..industryId = json['industryId'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$IndustryTypeToJson(IndustryType instance) =>
    <String, dynamic>{
      'industryId': instance.industryId,
      'name': instance.name,
      'description': instance.description
    };
