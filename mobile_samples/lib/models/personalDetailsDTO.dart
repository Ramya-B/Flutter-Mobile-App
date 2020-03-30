import 'package:json_annotation/json_annotation.dart';
import "details.dart";
import "mobile.dart";
import "email.dart";
part 'personalDetailsDTO.g.dart';

@JsonSerializable()
class PersonalDetailsDTO {
    PersonalDetailsDTO();

    Details details;
    Mobile mobile;
    Email email;
    String role;
    String secondaryMobile;
    String secondaryEmail;
    String registrationStatus;
    
    factory PersonalDetailsDTO.fromJson(Map<String,dynamic> json) => _$PersonalDetailsDTOFromJson(json);
    Map<String, dynamic> toJson() => _$PersonalDetailsDTOToJson(this);
}
