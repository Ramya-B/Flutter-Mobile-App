// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catgryProductAttributeDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatgryProductAttributeDTO _$CatgryProductAttributeDTOFromJson(
    Map<String, dynamic> json) {
  return CatgryProductAttributeDTO()
    ..categoryProductAttributeId = json['categoryProductAttributeId'] as num
    ..categoryId = json['categoryId'] as num
    ..productAttributeId = json['productAttributeId'] as String
    ..required = json['required'] as bool
    ..variant = json['variant'] as bool
    ..priority = json['priority'] as num
    ..archived = json['archived'] as bool
    ..deleted = json['deleted'] as bool
    ..dataType = json['dataType'] as String
    ..displayType = json['displayType'] as String
    ..facet = json['facet'] as bool
    ..sortable = json['sortable'] as bool
    ..searchable = json['searchable'] as bool
    ..inherited = json['inherited'] as bool
    ..lobId = json['lobId'] as String
    ..singleValue = json['singleValue'] as bool
    ..validation = json['validation'] as String
    ..facetPriority = json['facetPriority'] as String;
}

Map<String, dynamic> _$CatgryProductAttributeDTOToJson(
        CatgryProductAttributeDTO instance) =>
    <String, dynamic>{
      'categoryProductAttributeId': instance.categoryProductAttributeId,
      'categoryId': instance.categoryId,
      'productAttributeId': instance.productAttributeId,
      'required': instance.required,
      'variant': instance.variant,
      'priority': instance.priority,
      'archived': instance.archived,
      'deleted': instance.deleted,
      'dataType': instance.dataType,
      'displayType': instance.displayType,
      'facet': instance.facet,
      'sortable': instance.sortable,
      'searchable': instance.searchable,
      'inherited': instance.inherited,
      'lobId': instance.lobId,
      'singleValue': instance.singleValue,
      'validation': instance.validation,
      'facetPriority': instance.facetPriority
    };
