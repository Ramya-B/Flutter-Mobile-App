import 'package:json_annotation/json_annotation.dart';
import "partyCountryRegionDTO.dart";
part 'partyCountryRegionListDTO.g.dart';

@JsonSerializable()
class PartyCountryRegionListDTO {
    PartyCountryRegionListDTO();

    List<PartyCountryRegionDTO> partyCountryRegionDTO;
    String partyId;
    
    factory PartyCountryRegionListDTO.fromJson(Map<String,dynamic> json) => _$PartyCountryRegionListDTOFromJson(json);
    Map<String, dynamic> toJson() => _$PartyCountryRegionListDTOToJson(this);
}
