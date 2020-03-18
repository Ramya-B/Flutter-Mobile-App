// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createCategoryProductAttributeDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCategoryProductAttributeDTO _$CreateCategoryProductAttributeDTOFromJson(
    Map<String, dynamic> json) {
  return CreateCategoryProductAttributeDTO()
    ..productAttributeDTO = json['productAttributeDTO'] == null
        ? null
        : ProductAttributeDTO.fromJson(
            json['productAttributeDTO'] as Map<String, dynamic>)
    ..catgryProductAttributeDTO = json['catgryProductAttributeDTO'] == null
        ? null
        : CatgryProductAttributeDTO.fromJson(
            json['catgryProductAttributeDTO'] as Map<String, dynamic>)
    ..catProdAttrValues = (json['catProdAttrValues'] as List)
        ?.map((e) => e == null
            ? null
            : CatProdAttrValues.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..catProdAttrRoles = (json['catProdAttrRoles'] as List)
        ?.map((e) => e == null
            ? null
            : CatProdAttrRoles.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CreateCategoryProductAttributeDTOToJson(
        CreateCategoryProductAttributeDTO instance) =>
    <String, dynamic>{
      'productAttributeDTO': instance.productAttributeDTO,
      'catgryProductAttributeDTO': instance.catgryProductAttributeDTO,
      'catProdAttrValues': instance.catProdAttrValues,
      'catProdAttrRoles': instance.catProdAttrRoles
    };
