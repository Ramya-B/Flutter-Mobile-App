// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) {
  return ChatUser()
    ..description = json['description'] as String
    ..groupId = json['groupId'] as String
    ..securityPermissionDTO = (json['securityPermissionDTO'] as List)
        ?.map((e) => e == null
            ? null
            : SecurityPermissionDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'description': instance.description,
      'groupId': instance.groupId,
      'securityPermissionDTO': instance.securityPermissionDTO
    };
