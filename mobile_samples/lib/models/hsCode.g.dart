// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hsCode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HsCode _$HsCodeFromJson(Map<String, dynamic> json) {
  return HsCode()
    ..hscode = json['hscode'] as String
    ..countryCode = json['countryCode'] as String
    ..direction = json['direction'] as String
    ..lobId = json['lobId'] as String;
}

Map<String, dynamic> _$HsCodeToJson(HsCode instance) => <String, dynamic>{
      'hscode': instance.hscode,
      'countryCode': instance.countryCode,
      'direction': instance.direction,
      'lobId': instance.lobId
    };
