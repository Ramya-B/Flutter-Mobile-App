// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplierListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierListDto _$SupplierListDtoFromJson(Map<String, dynamic> json) {
  return SupplierListDto()
    ..toPartyId = json['toPartyId'] as String
    ..toPartyName = json['toPartyName'] as String
    ..productId = json['productId'] as String
    ..productName = json['productName'] as String
    ..productLobId = json['productLobId'] as String
    ..planUniqueId = json['planUniqueId'] as String
    ..childCustRequestId = json['childCustRequestId'] as num
    ..custRequestDelScheduleDTO = json['custRequestDelScheduleDTO'] as String;
}

Map<String, dynamic> _$SupplierListDtoToJson(SupplierListDto instance) =>
    <String, dynamic>{
      'toPartyId': instance.toPartyId,
      'toPartyName': instance.toPartyName,
      'productId': instance.productId,
      'productName': instance.productName,
      'productLobId': instance.productLobId,
      'planUniqueId': instance.planUniqueId,
      'childCustRequestId': instance.childCustRequestId,
      'custRequestDelScheduleDTO': instance.custRequestDelScheduleDTO
    };
