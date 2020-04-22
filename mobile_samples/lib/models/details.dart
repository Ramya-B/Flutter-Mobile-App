import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
    Details();

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
    String domainName;
    String groupName;
    String lobId;
    String countryCode;
    String groupNameLocal;
    String officeSiteName;
    String rejected;
    String reason;
    String logoImageUrl;
    String base64;
    
    factory Details.fromJson(Map<String,dynamic> json) => _$DetailsFromJson(json);
    Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
