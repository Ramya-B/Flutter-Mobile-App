// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partyCountryRegionListDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyCountryRegionListDTO _$PartyCountryRegionListDTOFromJson(
    Map<String, dynamic> json) {
  return PartyCountryRegionListDTO()
    ..partyCountryRegionDTO = (json['partyCountryRegionDTO'] as List)
        ?.map((e) => e == null
            ? null
            : PartyCountryRegionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..partyId = json['partyId'] as String;
}

Map<String, dynamic> _$PartyCountryRegionListDTOToJson(
        PartyCountryRegionListDTO instance) =>
    <String, dynamic>{
      'partyCountryRegionDTO': instance.partyCountryRegionDTO,
      'partyId': instance.partyId
    };
