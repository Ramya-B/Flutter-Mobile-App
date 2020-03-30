import 'package:json_annotation/json_annotation.dart';

part 'updatePasswordDto.g.dart';

@JsonSerializable()
class UpdatePasswordDto {
    UpdatePasswordDto();

    String userLoginId;
    String currentPassword;
    String newPassword;
    
    factory UpdatePasswordDto.fromJson(Map<String,dynamic> json) => _$UpdatePasswordDtoFromJson(json);
    Map<String, dynamic> toJson() => _$UpdatePasswordDtoToJson(this);
}
