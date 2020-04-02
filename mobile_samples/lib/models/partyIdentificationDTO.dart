import 'package:json_annotation/json_annotation.dart';
import "identificationAttributes.dart";
part 'partyIdentificationDTO.g.dart';

@JsonSerializable()
class PartyIdentificationDTO {
    PartyIdentificationDTO();

    String partyId;
    List<IdentificationAttributes> identificationAttributes;
    
    factory PartyIdentificationDTO.fromJson(Map<String,dynamic> json) => _$PartyIdentificationDTOFromJson(json);
    Map<String, dynamic> toJson() => _$PartyIdentificationDTOToJson(this);
}
