import 'package:json_annotation/json_annotation.dart';
import "partyType.dart";
import "telephone.dart";
import "email.dart";
import "company.dart";
import "person.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
    Profile();

    String unVerifiedSupplierFlag;
    String disabledReason;
    String sentOtpFailedReason;
    String isOtpSent;
    String registeredDate;
    PartyType partyType;
    String status;
    String address;
    List<Telephone> telephone;
    List<Email> email;
    Company company;
    Person person;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
