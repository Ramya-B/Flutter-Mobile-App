// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplierResponseListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierResponseListDto _$SupplierResponseListDtoFromJson(
    Map<String, dynamic> json) {
  return SupplierResponseListDto()
    ..requestDto = json['requestDto'] == null
        ? null
        : RequestDTO.fromJson(json['requestDto'] as Map<String, dynamic>)
    ..hasResponse = json['hasResponse'] as bool
    ..responseCount = json['responseCount'] as num
    ..unreadResponseCount = json['unreadResponseCount'] as num
    ..unreadMessageCount = json['unreadMessageCount'] as num;
}

Map<String, dynamic> _$SupplierResponseListDtoToJson(
        SupplierResponseListDto instance) =>
    <String, dynamic>{
      'requestDto': instance.requestDto,
      'hasResponse': instance.hasResponse,
      'responseCount': instance.responseCount,
      'unreadResponseCount': instance.unreadResponseCount,
      'unreadMessageCount': instance.unreadMessageCount
    };
