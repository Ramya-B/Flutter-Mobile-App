// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hsCodes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HsCodes _$HsCodesFromJson(Map<String, dynamic> json) {
  return HsCodes()
    ..hscode = json['hscode'] as String
    ..countryCode = json['countryCode'] as String
    ..direction = json['direction'] as String
    ..lobId = json['lobId'] as String;
}

Map<String, dynamic> _$HsCodesToJson(HsCodes instance) => <String, dynamic>{
      'hscode': instance.hscode,
      'countryCode': instance.countryCode,
      'direction': instance.direction,
      'lobId': instance.lobId
    };
