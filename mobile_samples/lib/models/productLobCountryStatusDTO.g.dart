// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productLobCountryStatusDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLobCountryStatusDTO _$ProductLobCountryStatusDTOFromJson(
    Map<String, dynamic> json) {
  return ProductLobCountryStatusDTO()
    ..productLobCountryStatusId = json['productLobCountryStatusId'] as String
    ..productId = json['productId'] as String
    ..lobId = json['lobId'] as String
    ..regionId = json['regionId'] as String
    ..countryId = json['countryId'] as String
    ..statusId = json['statusId'] as String
    ..reason = json['reason'] as String;
}

Map<String, dynamic> _$ProductLobCountryStatusDTOToJson(
        ProductLobCountryStatusDTO instance) =>
    <String, dynamic>{
      'productLobCountryStatusId': instance.productLobCountryStatusId,
      'productId': instance.productId,
      'lobId': instance.lobId,
      'regionId': instance.regionId,
      'countryId': instance.countryId,
      'statusId': instance.statusId,
      'reason': instance.reason
    };
