import 'package:json_annotation/json_annotation.dart';

part 'changePassword.g.dart';

@JsonSerializable()
class ChangePassword {
    ChangePassword();

    String userLoginId;
    String confirmationCode;
    String currentPassword;
    String newPassword;
    String firstName;
    
    factory ChangePassword.fromJson(Map<String,dynamic> json) => _$ChangePasswordFromJson(json);
    Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}
