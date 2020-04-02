import 'package:json_annotation/json_annotation.dart';
import "ownerAndRoleDTO.dart";
import "partyIdentificationDTO.dart";
import "profileAttribute.dart";
import "accountStatus.dart";
import "subscription.dart";
import "email.dart";
import "address.dart";
import "telephone.dart";
import "details.dart";
part 'company.g.dart';

@JsonSerializable()
class Company {
    Company();

    String channel;
    String lobId;
    String countryCode;
    bool admin;
    String registeredEmailAddress;
    String classifiedsStatus;
    String personPartyId;
    List partyContacts;
    List<OwnerAndRoleDTO> ownerAndRoleDTO;
    PartyIdentificationDTO partyIdentificationDTO;
    List<ProfileAttribute> profileAttribute;
    AccountStatus accountStatus;
    Subscription subscription;
    String classifications;
    String identifications;
    Email email;
    Address address;
    Telephone telephone;
    String status;
    Details details;
    
    factory Company.fromJson(Map<String,dynamic> json) => _$CompanyFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
