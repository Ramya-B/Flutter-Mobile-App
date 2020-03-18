// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catProdAttrValues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatProdAttrValues _$CatProdAttrValuesFromJson(Map<String, dynamic> json) {
  return CatProdAttrValues()
    ..id = json['id'] as num
    ..categoryProductAttributeId = json['categoryProductAttributeId'] as num
    ..name = json['name'] as String
    ..value = json['value'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$CatProdAttrValuesToJson(CatProdAttrValues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryProductAttributeId': instance.categoryProductAttributeId,
      'name': instance.name,
      'value': instance.value,
      'type': instance.type
    };
