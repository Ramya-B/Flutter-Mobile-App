// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyValueFacets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueFacets _$KeyValueFacetsFromJson(Map<String, dynamic> json) {
  return KeyValueFacets()
    ..name = json['name'] as String
    ..productOption = json['productOption'] as bool
    ..type = json['type'] as String
    ..value = json['value'] as bool;
}

Map<String, dynamic> _$KeyValueFacetsToJson(KeyValueFacets instance) =>
    <String, dynamic>{
      'name': instance.name,
      'productOption': instance.productOption,
      'type': instance.type,
      'value': instance.value
    };
