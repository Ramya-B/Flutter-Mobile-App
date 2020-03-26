import 'package:json_annotation/json_annotation.dart';
import "accountStatus.dart";
import "subscription.dart";
import "details.dart";
part 'company.g.dart';

@JsonSerializable()
class Company {
    Company();

    bool admin;
    String registeredEmailAddress;
    String classifiedsStatus;
    String personPartyId;
    String partyContacts;
    String ownerAndRoleDTO;
    String partyIdentificationDTO;
    String profileAttribute;
    AccountStatus accountStatus;
    Subscription subscription;
    String classifications;
    String identifications;
    String email;
    String address;
    String telephone;
    String status;
    Details details;
    
    factory Company.fromJson(Map<String,dynamic> json) => _$CompanyFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
