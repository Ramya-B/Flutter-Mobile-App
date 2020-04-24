// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiriesResponseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquiriesResponseDto _$InquiriesResponseDtoFromJson(Map<String, dynamic> json) {
  return InquiriesResponseDto()
    ..parentRequestDTO = json['parentRequestDTO'] == null
        ? null
        : ParentRequestDTO.fromJson(
            json['parentRequestDTO'] as Map<String, dynamic>)
    ..requestDetails = (json['requestDetails'] as List)
        ?.map((e) => e == null
            ? null
            : RequestDetails.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as num;
}

Map<String, dynamic> _$InquiriesResponseDtoToJson(
        InquiriesResponseDto instance) =>
    <String, dynamic>{
      'parentRequestDTO': instance.parentRequestDTO,
      'requestDetails': instance.requestDetails,
      'totalCount': instance.totalCount
    };
