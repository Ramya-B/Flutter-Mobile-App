// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResp _$ProfileRespFromJson(Map<String, dynamic> json) {
  return ProfileResp()
    ..personalDetailsDTO = json['personalDetailsDTO'] == null
        ? null
        : PersonalDetailsDTO.fromJson(
            json['personalDetailsDTO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProfileRespToJson(ProfileResp instance) =>
    <String, dynamic>{'personalDetailsDTO': instance.personalDetailsDTO};
