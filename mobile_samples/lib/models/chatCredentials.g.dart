// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatCredentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCredentials _$ChatCredentialsFromJson(Map<String, dynamic> json) {
  return ChatCredentials()
    ..jid = json['jid'] as String
    ..sid = json['sid'] as String
    ..rid = json['rid'] as num;
}

Map<String, dynamic> _$ChatCredentialsToJson(ChatCredentials instance) =>
    <String, dynamic>{
      'jid': instance.jid,
      'sid': instance.sid,
      'rid': instance.rid
    };
