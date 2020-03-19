import 'package:json_annotation/json_annotation.dart';

part 'partyCountryRegionDTO.g.dart';

@JsonSerializable()
class PartyCountryRegionDTO {
    PartyCountryRegionDTO();

    String partyCountryRegionId;
    String countryId;
    String countryName;
    String regionId;
    
    factory PartyCountryRegionDTO.fromJson(Map<String,dynamic> json) => _$PartyCountryRegionDTOFromJson(json);
    Map<String, dynamic> toJson() => _$PartyCountryRegionDTOToJson(this);
}
