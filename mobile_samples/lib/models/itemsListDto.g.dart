// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemsListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsListDto _$ItemsListDtoFromJson(Map<String, dynamic> json) {
  return ItemsListDto()
    ..customerRequestItemId = json['customerRequestItemId'] as String
    ..customerRequestId = json['customerRequestId'] as num
    ..statusId = json['statusId'] as String
    ..priority = json['priority'] as String
    ..sequenceNum = json['sequenceNum'] as String
    ..requiredByDate = json['requiredByDate'] as String
    ..productId = json['productId'] as String
    ..quantity = json['quantity'] as num
    ..quantityType = json['quantityType'] as String
    ..selectedAmount = json['selectedAmount'] as num
    ..maximumAmount = json['maximumAmount'] as String
    ..reservStart = json['reservStart'] as String
    ..reservLength = json['reservLength'] as String
    ..reservPersons = json['reservPersons'] as String
    ..description = json['description'] as String
    ..story = json['story'] as String
    ..reqByDate = json['reqByDate'] as String
    ..globalPriceFlag = json['globalPriceFlag'] as String;
}

Map<String, dynamic> _$ItemsListDtoToJson(ItemsListDto instance) =>
    <String, dynamic>{
      'customerRequestItemId': instance.customerRequestItemId,
      'customerRequestId': instance.customerRequestId,
      'statusId': instance.statusId,
      'priority': instance.priority,
      'sequenceNum': instance.sequenceNum,
      'requiredByDate': instance.requiredByDate,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'quantityType': instance.quantityType,
      'selectedAmount': instance.selectedAmount,
      'maximumAmount': instance.maximumAmount,
      'reservStart': instance.reservStart,
      'reservLength': instance.reservLength,
      'reservPersons': instance.reservPersons,
      'description': instance.description,
      'story': instance.story,
      'reqByDate': instance.reqByDate,
      'globalPriceFlag': instance.globalPriceFlag
    };
