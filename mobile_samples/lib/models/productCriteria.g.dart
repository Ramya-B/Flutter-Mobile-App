// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productCriteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCriteria _$ProductCriteriaFromJson(Map<String, dynamic> json) {
  return ProductCriteria()
    ..pagination = json['pagination']
    ..sort = json['sort'] as List
    ..siteCriterias = json['siteCriterias'] as List;
}

Map<String, dynamic> _$ProductCriteriaToJson(ProductCriteria instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'sort': instance.sort,
      'siteCriterias': instance.siteCriterias
    };
