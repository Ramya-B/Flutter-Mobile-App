// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classificationGroupAttributeDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationGroupAttributeDTO _$ClassificationGroupAttributeDTOFromJson(
    Map<String, dynamic> json) {
  return ClassificationGroupAttributeDTO()
    ..attributeId = json['attributeId'] as String
    ..attributeName = json['attributeName'] as String
    ..attributeDescription = json['attributeDescription'] as String
    ..groupId = json['groupId'] as String
    ..parentAttributeId = json['parentAttributeId'] as String
    ..isChecked = json['isChecked'] as bool;
}

Map<String, dynamic> _$ClassificationGroupAttributeDTOToJson(
        ClassificationGroupAttributeDTO instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
      'attributeName': instance.attributeName,
      'attributeDescription': instance.attributeDescription,
      'groupId': instance.groupId,
      'parentAttributeId': instance.parentAttributeId,
      'isChecked': instance.isChecked
    };
