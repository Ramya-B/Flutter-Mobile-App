// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details()
    ..reason = json['reason'] as String
    ..rejected = json['rejected'] as String
    ..channel = json['channel'] as String
    ..lobId = json['lobId'] as String
    ..countryCode = json['countryCode'] as String
    ..companyCode = json['companyCode'] as String
    ..tenantId = json['tenantId'] as String
    ..logoImageUrl = json['logoImageUrl'] as String
    ..comments = json['comments'] as String
    ..tickerSymbol = json['tickerSymbol'] as String
    ..numEmployees = json['numEmployees'] as String
    ..annualRevenue = json['annualRevenue'] as String
    ..officeSiteName = json['officeSiteName'] as String
    ..groupNameLocal = json['groupNameLocal'] as String
    ..groupName = json['groupName'] as String
    ..partyId = json['partyId'] as String;
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'reason': instance.reason,
      'rejected': instance.rejected,
      'channel': instance.channel,
      'lobId': instance.lobId,
      'countryCode': instance.countryCode,
      'companyCode': instance.companyCode,
      'tenantId': instance.tenantId,
      'logoImageUrl': instance.logoImageUrl,
      'comments': instance.comments,
      'tickerSymbol': instance.tickerSymbol,
      'numEmployees': instance.numEmployees,
      'annualRevenue': instance.annualRevenue,
      'officeSiteName': instance.officeSiteName,
      'groupNameLocal': instance.groupNameLocal,
      'groupName': instance.groupName,
      'partyId': instance.partyId
    };
