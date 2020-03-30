import 'package:json_annotation/json_annotation.dart';
import "sendConfirmationDto.dart";
part 'resend.g.dart';

@JsonSerializable()
class Resend {
    Resend();

    String currentUserLoginId;
    String newUserLoginId;
    bool isPwdChange;
    SendConfirmationDto sendConfirmationDto;
    String firstName;
    String visitedregion;
    
    factory Resend.fromJson(Map<String,dynamic> json) => _$ResendFromJson(json);
    Map<String, dynamic> toJson() => _$ResendToJson(this);
}
