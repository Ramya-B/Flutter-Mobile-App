// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price()
    ..priceList = (json['priceList'] as List)
        ?.map((e) =>
            e == null ? null : PriceList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PriceToJson(Price instance) =>
    <String, dynamic>{'priceList': instance.priceList};
