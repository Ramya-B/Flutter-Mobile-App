// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catProdAttrLoBListDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatProdAttrLoBListDTO _$CatProdAttrLoBListDTOFromJson(
    Map<String, dynamic> json) {
  return CatProdAttrLoBListDTO()
    ..lobId = json['lobId'] as String
    ..createCategoryProductAttributeDTO =
        (json['createCategoryProductAttributeDTO'] as List)
            ?.map((e) => e == null
                ? null
                : CreateCategoryProductAttributeDTO.fromJson(
                    e as Map<String, dynamic>))
            ?.toList();
}

Map<String, dynamic> _$CatProdAttrLoBListDTOToJson(
        CatProdAttrLoBListDTO instance) =>
    <String, dynamic>{
      'lobId': instance.lobId,
      'createCategoryProductAttributeDTO':
          instance.createCategoryProductAttributeDTO
    };
