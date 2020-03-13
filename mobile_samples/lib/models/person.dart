import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
    Person();

    bool optIn;
    String tenantId;
    String occupation;
    String existingCustomer;
    String comments;
    String passportExpireDate;
    String passportNumber;
    String socialSecurityNumber;
    String maritalStatus;
    String mothersMaidenName;
    String weight;
    String height;
    String birthDate;
    String gender;
    String memberId;
    String otherLocal;
    String lastNameLocal;
    String middleNameLocal;
    String firstNameLocal;
    String nickname;
    String suffix;
    String personalTitle;
    String lastName;
    String middleName;
    String firstName;
    String salutation;
    String partyId;
    
    factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);
    Map<String, dynamic> toJson() => _$PersonToJson(this);
}
