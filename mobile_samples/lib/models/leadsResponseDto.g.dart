// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leadsResponseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadsResponseDto _$LeadsResponseDtoFromJson(Map<String, dynamic> json) {
  return LeadsResponseDto()
    ..supplierResponseListDto = (json['supplierResponseListDto'] as List)
        ?.map((e) => e == null
            ? null
            : SupplierResponseListDto.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as num;
}

Map<String, dynamic> _$LeadsResponseDtoToJson(LeadsResponseDto instance) =>
    <String, dynamic>{
      'supplierResponseListDto': instance.supplierResponseListDto,
      'totalCount': instance.totalCount
    };
