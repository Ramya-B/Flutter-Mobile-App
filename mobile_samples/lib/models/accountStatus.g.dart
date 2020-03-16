// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountStatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountStatus _$AccountStatusFromJson(Map<String, dynamic> json) {
  return AccountStatus()
    ..companyId = json['companyId'] as String
    ..reason = json['reason'] as String
    ..rejected = json['rejected'] as String
    ..statusOn = json['statusOn'] as String
    ..statusId = json['statusId'] as String;
}

Map<String, dynamic> _$AccountStatusToJson(AccountStatus instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'reason': instance.reason,
      'rejected': instance.rejected,
      'statusOn': instance.statusOn,
      'statusId': instance.statusId
    };
