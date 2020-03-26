// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) {
  return ProductDTO()
    ..productAttributeDetailDTO = (json['productAttributeDetailDTO'] as List)
        ?.map((e) => e == null
            ? null
            : ProductAttributeDetailDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productOptionDTO = (json['productOptionDTO'] as List)
        ?.map((e) => e == null
            ? null
            : ProductOptionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productLobCountryStatusDTO = (json['productLobCountryStatusDTO'] as List)
        ?.map((e) => e == null
            ? null
            : ProductLobCountryStatusDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productName = json['productName'] as String
    ..primaryImageUrl = json['primaryImageUrl'] as String
    ..type = json['type'] as String
    ..channel = json['channel'] as String
    ..region = json['region'] as String
    ..hsCodes = (json['hsCodes'] as List)
        ?.map((e) =>
            e == null ? null : HsCodes.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..status = json['status'] as String
    ..categoryIds = json['categoryIds'] as List
    ..selectedSites = json['selectedSites'] as List
    ..supplierId = json['supplierId'] as String;
}

Map<String, dynamic> _$ProductDTOToJson(ProductDTO instance) =>
    <String, dynamic>{
      'productAttributeDetailDTO': instance.productAttributeDetailDTO,
      'productOptionDTO': instance.productOptionDTO,
      'productLobCountryStatusDTO': instance.productLobCountryStatusDTO,
      'productName': instance.productName,
      'primaryImageUrl': instance.primaryImageUrl,
      'type': instance.type,
      'channel': instance.channel,
      'region': instance.region,
      'hsCodes': instance.hsCodes,
      'status': instance.status,
      'categoryIds': instance.categoryIds,
      'selectedSites': instance.selectedSites,
      'supplierId': instance.supplierId
    };
