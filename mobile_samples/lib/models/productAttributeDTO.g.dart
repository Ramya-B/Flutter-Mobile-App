// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAttributeDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributeDTO _$ProductAttributeDTOFromJson(Map<String, dynamic> json) {
  return ProductAttributeDTO()
    ..productAttributeId = json['productAttributeId'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..archived = json['archived'] as bool
    ..deletable = json['deletable'] as bool;
}

Map<String, dynamic> _$ProductAttributeDTOToJson(
        ProductAttributeDTO instance) =>
    <String, dynamic>{
      'productAttributeId': instance.productAttributeId,
      'name': instance.name,
      'description': instance.description,
      'archived': instance.archived,
      'deletable': instance.deletable
    };
