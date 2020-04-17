// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productPriceSlabs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPriceSlabs _$ProductPriceSlabsFromJson(Map<String, dynamic> json) {
  return ProductPriceSlabs()
    ..price = json['price'] as String
    ..rangeStart = json['rangeStart'] as num
    ..qtyStart = json['qtyStart'] as String
    ..qtyEnd = json['qtyEnd'] as String
    ..priceStart = json['priceStart'] as String
    ..priceEnd = json['priceEnd'] as String
    ..isQtyError = json['isQtyError'] as bool;
}

Map<String, dynamic> _$ProductPriceSlabsToJson(ProductPriceSlabs instance) =>
    <String, dynamic>{
      'price': instance.price,
      'rangeStart': instance.rangeStart,
      'qtyStart': instance.qtyStart,
      'qtyEnd': instance.qtyEnd,
      'priceStart': instance.priceStart,
      'priceEnd': instance.priceEnd,
      'isQtyError': instance.isQtyError
    };
