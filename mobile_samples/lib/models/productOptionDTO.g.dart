// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productOptionDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionDTO _$ProductOptionDTOFromJson(Map<String, dynamic> json) {
  return ProductOptionDTO()
    ..productOptionName = json['productOptionName'] as String
    ..start = json['start'] as String
    ..supplierSKUId = json['supplierSKUId'] as num
    ..imageDTO = (json['imageDTO'] as List)
        ?.map((e) =>
            e == null ? null : ImageDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productAttributeDetailDTO = (json['productAttributeDetailDTO'] as List)
        ?.map((e) => e == null
            ? null
            : ProductAttributeDetailDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..priceList = (json['priceList'] as List)
        ?.map((e) =>
            e == null ? null : PriceList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..deliveryScheduleDTO = json['deliveryScheduleDTO'] as List;
}

Map<String, dynamic> _$ProductOptionDTOToJson(ProductOptionDTO instance) =>
    <String, dynamic>{
      'productOptionName': instance.productOptionName,
      'start': instance.start,
      'supplierSKUId': instance.supplierSKUId,
      'imageDTO': instance.imageDTO,
      'productAttributeDetailDTO': instance.productAttributeDetailDTO,
      'priceList': instance.priceList,
      'deliveryScheduleDTO': instance.deliveryScheduleDTO
    };
