import 'package:json_annotation/json_annotation.dart';

part 'sendConfirmationDto.g.dart';

@JsonSerializable()
class SendConfirmationDto {
    SendConfirmationDto();

    String mobileNumber;
    String partyId;
    String verificationType;
    bool optIn;
    String countryCode;
    String contactNumber;
    
    factory SendConfirmationDto.fromJson(Map<String,dynamic> json) => _$SendConfirmationDtoFromJson(json);
    Map<String, dynamic> toJson() => _$SendConfirmationDtoToJson(this);
}
