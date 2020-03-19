// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAttributesResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributesResp _$ProductAttributesRespFromJson(
    Map<String, dynamic> json) {
  return ProductAttributesResp()
    ..listCatProdAttrLoBRespDTO = json['listCatProdAttrLoBRespDTO'] == null
        ? null
        : ListCatProdAttrLoBRespDTO.fromJson(
            json['listCatProdAttrLoBRespDTO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProductAttributesRespToJson(
        ProductAttributesResp instance) =>
    <String, dynamic>{
      'listCatProdAttrLoBRespDTO': instance.listCatProdAttrLoBRespDTO
    };
