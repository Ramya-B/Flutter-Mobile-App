// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productCriteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCriteria _$ProductCriteriaFromJson(Map<String, dynamic> json) {
  return ProductCriteria()
    ..pagination = json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
    ..sort = (json['sort'] as List)
        ?.map(
            (e) => e == null ? null : Sort.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..siteCriterias = json['siteCriterias'] as List;
}

Map<String, dynamic> _$ProductCriteriaToJson(ProductCriteria instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'sort': instance.sort,
      'siteCriterias': instance.siteCriterias
    };
