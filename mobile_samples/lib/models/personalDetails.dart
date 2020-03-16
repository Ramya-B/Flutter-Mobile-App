import 'package:json_annotation/json_annotation.dart';
import "profile.dart";
part 'personalDetails.g.dart';

@JsonSerializable()
class PersonalDetails {
    PersonalDetails();

    num protocolVersion;
    Profile profile;
    
    factory PersonalDetails.fromJson(Map<String,dynamic> json) => _$PersonalDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$PersonalDetailsToJson(this);
}
