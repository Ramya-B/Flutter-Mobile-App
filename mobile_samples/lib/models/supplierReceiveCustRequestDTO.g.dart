// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplierReceiveCustRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierReceiveCustRequestDTO _$SupplierReceiveCustRequestDTOFromJson(
    Map<String, dynamic> json) {
  return SupplierReceiveCustRequestDTO()
    ..startIndex = json['startIndex'] as num
    ..size = json['size'] as num
    ..lobId = json['lobId'] as String
    ..supplierStatus = json['supplierStatus'] as String;
}

Map<String, dynamic> _$SupplierReceiveCustRequestDTOToJson(
        SupplierReceiveCustRequestDTO instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'size': instance.size,
      'lobId': instance.lobId,
      'supplierStatus': instance.supplierStatus
    };
