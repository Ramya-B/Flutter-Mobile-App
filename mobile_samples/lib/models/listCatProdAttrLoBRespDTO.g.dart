// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listCatProdAttrLoBRespDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCatProdAttrLoBRespDTO _$ListCatProdAttrLoBRespDTOFromJson(
    Map<String, dynamic> json) {
  return ListCatProdAttrLoBRespDTO()
    ..createCategoryProductAttributeDTO =
        (json['createCategoryProductAttributeDTO'] as List)
            ?.map((e) => e == null
                ? null
                : CreateCategoryProductAttributeDTO.fromJson(
                    e as Map<String, dynamic>))
            ?.toList()
    ..catProdAttrLoBListDTO = (json['catProdAttrLoBListDTO'] as List)
        ?.map((e) => e == null
            ? null
            : CatProdAttrLoBListDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListCatProdAttrLoBRespDTOToJson(
        ListCatProdAttrLoBRespDTO instance) =>
    <String, dynamic>{
      'createCategoryProductAttributeDTO':
          instance.createCategoryProductAttributeDTO,
      'catProdAttrLoBListDTO': instance.catProdAttrLoBListDTO
    };
