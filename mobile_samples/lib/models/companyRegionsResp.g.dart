// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companyRegionsResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyRegionsResp _$CompanyRegionsRespFromJson(Map<String, dynamic> json) {
  return CompanyRegionsResp()
    ..partyCountryRegionListDTO = json['partyCountryRegionListDTO'] == null
        ? null
        : PartyCountryRegionListDTO.fromJson(
            json['partyCountryRegionListDTO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CompanyRegionsRespToJson(CompanyRegionsResp instance) =>
    <String, dynamic>{
      'partyCountryRegionListDTO': instance.partyCountryRegionListDTO
    };
