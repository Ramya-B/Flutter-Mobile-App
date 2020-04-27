// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplierResponseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierResponseDto _$SupplierResponseDtoFromJson(Map<String, dynamic> json) {
  return SupplierResponseDto()
    ..supplierResponseListDto = (json['supplierResponseListDto'] as List)
        ?.map((e) => e == null
            ? null
            : SupplierResponseListDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SupplierResponseDtoToJson(
        SupplierResponseDto instance) =>
    <String, dynamic>{
      'supplierResponseListDto': instance.supplierResponseListDto
    };
