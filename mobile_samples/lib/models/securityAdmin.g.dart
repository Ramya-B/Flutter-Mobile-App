// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securityAdmin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityAdmin _$SecurityAdminFromJson(Map<String, dynamic> json) {
  return SecurityAdmin()
    ..description = json['description'] as String
    ..groupId = json['groupId'] as String
    ..securityPermissionDTO = (json['securityPermissionDTO'] as List)
        ?.map((e) => e == null
            ? null
            : SecurityPermissionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SecurityAdminToJson(SecurityAdmin instance) =>
    <String, dynamic>{
      'description': instance.description,
      'groupId': instance.groupId,
      'securityPermissionDTO': instance.securityPermissionDTO
    };
