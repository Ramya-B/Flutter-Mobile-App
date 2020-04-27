// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expiredLeadsResponseDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpiredLeadsResponseDto _$ExpiredLeadsResponseDtoFromJson(
    Map<String, dynamic> json) {
  return ExpiredLeadsResponseDto()
    ..supplierResponseDto = json['supplierResponseDto'] == null
        ? null
        : SupplierResponseDto.fromJson(
            json['supplierResponseDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ExpiredLeadsResponseDtoToJson(
        ExpiredLeadsResponseDto instance) =>
    <String, dynamic>{'supplierResponseDto': instance.supplierResponseDto};
