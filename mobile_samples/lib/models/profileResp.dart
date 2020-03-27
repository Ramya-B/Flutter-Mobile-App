import 'package:json_annotation/json_annotation.dart';
import "personalDetailsDTO.dart";
part 'profileResp.g.dart';

@JsonSerializable()
class ProfileResp {
    ProfileResp();

    PersonalDetailsDTO personalDetailsDTO;
    
    factory ProfileResp.fromJson(Map<String,dynamic> json) => _$ProfileRespFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileRespToJson(this);
}
