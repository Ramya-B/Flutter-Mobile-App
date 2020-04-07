// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priceList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceList _$PriceListFromJson(Map<String, dynamic> json) {
  return PriceList()
    ..currency = json['currency'] as String
    ..lobId = json['lobId'] as String
    ..priceType = json['priceType'] as String
    ..productPriceSlabs = (json['productPriceSlabs'] as List)
        ?.map((e) => e == null
            ? null
            : ProductPriceSlabs.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..unitType = json['unitType'] as String;
}

Map<String, dynamic> _$PriceListToJson(PriceList instance) => <String, dynamic>{
      'currency': instance.currency,
      'lobId': instance.lobId,
      'priceType': instance.priceType,
      'productPriceSlabs': instance.productPriceSlabs,
      'unitType': instance.unitType
    };
