// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDetails _$PersonalDetailsFromJson(Map<String, dynamic> json) {
  return PersonalDetails()
    ..protocolVersion = json['protocolVersion'] as num
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PersonalDetailsToJson(PersonalDetails instance) =>
    <String, dynamic>{
      'protocolVersion': instance.protocolVersion,
      'profile': instance.profile
    };
