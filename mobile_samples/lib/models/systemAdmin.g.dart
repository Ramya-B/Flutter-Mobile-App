// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systemAdmin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemAdmin _$SystemAdminFromJson(Map<String, dynamic> json) {
  return SystemAdmin()
    ..description = json['description'] as String
    ..groupId = json['groupId'] as String
    ..securityPermissionDTO = (json['securityPermissionDTO'] as List)
        ?.map((e) => e == null
            ? null
            : SecurityPermissionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SystemAdminToJson(SystemAdmin instance) =>
    <String, dynamic>{
      'description': instance.description,
      'groupId': instance.groupId,
      'securityPermissionDTO': instance.securityPermissionDTO
    };
