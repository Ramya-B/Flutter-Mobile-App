import 'package:json_annotation/json_annotation.dart';
import "updatePasswordDto.dart";
part 'updatePasswordRequest.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
    UpdatePasswordRequest();

    UpdatePasswordDto updatePasswordDto;
    
    factory UpdatePasswordRequest.fromJson(Map<String,dynamic> json) => _$UpdatePasswordRequestFromJson(json);
    Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}
