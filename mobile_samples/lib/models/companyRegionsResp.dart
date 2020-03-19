import 'package:json_annotation/json_annotation.dart';
import "partyCountryRegionListDTO.dart";
part 'companyRegionsResp.g.dart';

@JsonSerializable()
class CompanyRegionsResp {
    CompanyRegionsResp();

    PartyCountryRegionListDTO partyCountryRegionListDTO;
    
    factory CompanyRegionsResp.fromJson(Map<String,dynamic> json) => _$CompanyRegionsRespFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyRegionsRespToJson(this);
}
