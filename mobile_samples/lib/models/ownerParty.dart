import 'package:json_annotation/json_annotation.dart';

part 'ownerParty.g.dart';

@JsonSerializable()
class OwnerParty {
    OwnerParty();

    String partyId;
    String salutation;
    String firstName;
    String middleName;
    String lastName;
    String personalTitle;
    String suffix;
    String nickname;
    String firstNameLocal;
    String middleNameLocal;
    String lastNameLocal;
    String otherLocal;
    String memberId;
    String gender;
    String birthDate;
    String height;
    String weight;
    String mothersMaidenName;
    String maritalStatus;
    String socialSecurityNumber;
    String passportNumber;
    String passportExpireDate;
    String comments;
    String existingCustomer;
    String occupation;
    String tenantId;
    bool optIn;
    
    factory OwnerParty.fromJson(Map<String,dynamic> json) => _$OwnerPartyFromJson(json);
    Map<String, dynamic> toJson() => _$OwnerPartyToJson(this);
}
