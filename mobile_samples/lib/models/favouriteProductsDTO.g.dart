// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favouriteProductsDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteProductsDTO _$FavouriteProductsDTOFromJson(Map<String, dynamic> json) {
  return FavouriteProductsDTO()
    ..favouriteId = json['favouriteId'] as String
    ..partyId = json['partyId'] as String
    ..productId = json['productId'] as String
    ..productImageUrl = json['productImageUrl'] as String
    ..productName = json['productName'] as String
    ..suppplierName = json['suppplierName'] as String;
}

Map<String, dynamic> _$FavouriteProductsDTOToJson(
        FavouriteProductsDTO instance) =>
    <String, dynamic>{
      'favouriteId': instance.favouriteId,
      'partyId': instance.partyId,
      'productId': instance.productId,
      'productImageUrl': instance.productImageUrl,
      'productName': instance.productName,
      'suppplierName': instance.suppplierName
    };
