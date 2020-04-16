// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryScheduleDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryScheduleDTO _$DeliveryScheduleDTOFromJson(Map<String, dynamic> json) {
  return DeliveryScheduleDTO()
    ..deliveryScheduleId = json['deliveryScheduleId'] as String
    ..minValue = json['minValue'] as num
    ..maxValue = json['maxValue'] as num
    ..incoTerms = json['incoTerms'] as String
    ..unitType = json['unitType'] as String
    ..attributeId = json['attributeId'] as String
    ..attributeName = json['attributeName'] as String
    ..lobId = json['lobId'] as String;
}

Map<String, dynamic> _$DeliveryScheduleDTOToJson(
        DeliveryScheduleDTO instance) =>
    <String, dynamic>{
      'deliveryScheduleId': instance.deliveryScheduleId,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'incoTerms': instance.incoTerms,
      'unitType': instance.unitType,
      'attributeId': instance.attributeId,
      'attributeName': instance.attributeName,
      'lobId': instance.lobId
    };
