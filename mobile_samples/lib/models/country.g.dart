// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country()
    ..code = json['code'] as String
    ..isoAlpha3 = json['isoAlpha3'] as String
    ..country = json['country'] as String
    ..language = json['language'] as String
    ..currency = json['currency'] as String
    ..callingCode = json['callingCode'] as String
    ..active = json['active'] as bool
    ..mobileOtpFlag = json['mobileOtpFlag'] as String;
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'code': instance.code,
      'isoAlpha3': instance.isoAlpha3,
      'country': instance.country,
      'language': instance.language,
      'currency': instance.currency,
      'callingCode': instance.callingCode,
      'active': instance.active,
      'mobileOtpFlag': instance.mobileOtpFlag
    };
