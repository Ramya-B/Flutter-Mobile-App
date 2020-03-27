import 'package:json_annotation/json_annotation.dart';

part 'changeUserPassword.g.dart';

@JsonSerializable()
class ChangeUserPassword {
    ChangeUserPassword();

    String userLoginId;
    String confirmationCode;
    String currentPassword;
    String newPassword;
    String firstName;
    
    factory ChangeUserPassword.fromJson(Map<String,dynamic> json) => _$ChangeUserPasswordFromJson(json);
    Map<String, dynamic> toJson() => _$ChangeUserPasswordToJson(this);
}
