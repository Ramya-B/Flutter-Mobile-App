// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classificationDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationDetails _$ClassificationDetailsFromJson(
    Map<String, dynamic> json) {
  return ClassificationDetails()
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..value = json['value'] as String;
}

Map<String, dynamic> _$ClassificationDetailsToJson(
        ClassificationDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value
    };
