// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productPriceSlabs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPriceSlabs _$ProductPriceSlabsFromJson(Map<String, dynamic> json) {
  return ProductPriceSlabs()
    ..price = json['price'] as String
    ..rangeStart = json['rangeStart'] as num;
}

Map<String, dynamic> _$ProductPriceSlabsToJson(ProductPriceSlabs instance) =>
    <String, dynamic>{
      'price': instance.price,
      'rangeStart': instance.rangeStart
    };
