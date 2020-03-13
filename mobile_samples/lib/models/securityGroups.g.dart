// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securityGroups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityGroups _$SecurityGroupsFromJson(Map<String, dynamic> json) {
  return SecurityGroups()
    ..securityAdmin = json['securityAdmin'] == null
        ? null
        : SecurityAdmin.fromJson(json['securityAdmin'] as Map<String, dynamic>)
    ..chatUser = json['chatUser'] == null
        ? null
        : ChatUser.fromJson(json['chatUser'] as Map<String, dynamic>)
    ..systemAdmin = json['systemAdmin'] == null
        ? null
        : SystemAdmin.fromJson(json['systemAdmin'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SecurityGroupsToJson(SecurityGroups instance) =>
    <String, dynamic>{
      'securityAdmin': instance.securityAdmin,
      'chatUser': instance.chatUser,
      'systemAdmin': instance.systemAdmin
    };
