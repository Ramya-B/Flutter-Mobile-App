// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sendConfirmationDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendConfirmationDto _$SendConfirmationDtoFromJson(Map<String, dynamic> json) {
  return SendConfirmationDto()
    ..mobileNumber = json['mobileNumber'] as String
    ..partyId = json['partyId'] as String
    ..verificationType = json['verificationType'] as String
    ..optIn = json['optIn'] as bool
    ..countryCode = json['countryCode'] as String
    ..contactNumber = json['contactNumber'] as String;
}

Map<String, dynamic> _$SendConfirmationDtoToJson(
        SendConfirmationDto instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'partyId': instance.partyId,
      'verificationType': instance.verificationType,
      'optIn': instance.optIn,
      'countryCode': instance.countryCode,
      'contactNumber': instance.contactNumber
    };
