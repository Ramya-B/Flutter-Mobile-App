// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leadDetailResponseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadDetailResponseDto _$LeadDetailResponseDtoFromJson(
    Map<String, dynamic> json) {
  return LeadDetailResponseDto()
    ..requestDTO = json['requestDTO'] == null
        ? null
        : RequestDetailDto.fromJson(json['requestDTO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LeadDetailResponseDtoToJson(
        LeadDetailResponseDto instance) =>
    <String, dynamic>{'requestDTO': instance.requestDTO};
