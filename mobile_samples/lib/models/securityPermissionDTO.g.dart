// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securityPermissionDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityPermissionDTO _$SecurityPermissionDTOFromJson(
    Map<String, dynamic> json) {
  return SecurityPermissionDTO()
    ..description = json['description'] as String
    ..permissionId = json['permissionId'] as String;
}

Map<String, dynamic> _$SecurityPermissionDTOToJson(
        SecurityPermissionDTO instance) =>
    <String, dynamic>{
      'description': instance.description,
      'permissionId': instance.permissionId
    };
