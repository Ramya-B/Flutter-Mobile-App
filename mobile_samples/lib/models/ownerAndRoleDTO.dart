import 'package:json_annotation/json_annotation.dart';
import "ownerParty.dart";
import "telephone.dart";
import "email.dart";
part 'ownerAndRoleDTO.g.dart';

@JsonSerializable()
class OwnerAndRoleDTO {
    OwnerAndRoleDTO();

    OwnerParty ownerParty;
    String roleDTO;
    Telephone telephoneDTO;
    Email emailContactDTO;
    String companyPartyId;
    bool admin;
    
    factory OwnerAndRoleDTO.fromJson(Map<String,dynamic> json) => _$OwnerAndRoleDTOFromJson(json);
    Map<String, dynamic> toJson() => _$OwnerAndRoleDTOToJson(this);
}
