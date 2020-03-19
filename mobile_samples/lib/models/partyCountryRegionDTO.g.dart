// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partyCountryRegionDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyCountryRegionDTO _$PartyCountryRegionDTOFromJson(
    Map<String, dynamic> json) {
  return PartyCountryRegionDTO()
    ..partyCountryRegionId = json['partyCountryRegionId'] as String
    ..countryId = json['countryId'] as String
    ..countryName = json['countryName'] as String
    ..regionId = json['regionId'] as String;
}

Map<String, dynamic> _$PartyCountryRegionDTOToJson(
        PartyCountryRegionDTO instance) =>
    <String, dynamic>{
      'partyCountryRegionId': instance.partyCountryRegionId,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'regionId': instance.regionId
    };
