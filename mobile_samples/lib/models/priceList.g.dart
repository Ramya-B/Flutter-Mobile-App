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
    ..unitType = json['unitType'] as String
    ..incoterms = json['incoterms'] as String
    ..isIncoSelected = json['isIncoSelected'] as bool
    ..edcStart = json['edcStart'] as String
    ..edcEnd = json['edcEnd'] as String
    ..edcSelectedTime = json['edcSelectedTime'] as String
    ..attributeName = json['attributeName'] as String;
}

Map<String, dynamic> _$PriceListToJson(PriceList instance) => <String, dynamic>{
      'currency': instance.currency,
      'lobId': instance.lobId,
      'priceType': instance.priceType,
      'productPriceSlabs': instance.productPriceSlabs,
      'unitType': instance.unitType,
      'incoterms': instance.incoterms,
      'isIncoSelected': instance.isIncoSelected,
      'edcStart': instance.edcStart,
      'edcEnd': instance.edcEnd,
      'edcSelectedTime': instance.edcSelectedTime,
      'attributeName': instance.attributeName
    };
