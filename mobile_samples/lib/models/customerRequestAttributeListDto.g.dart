// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerRequestAttributeListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequestAttributeListDto _$CustomerRequestAttributeListDtoFromJson(
    Map<String, dynamic> json) {
  return CustomerRequestAttributeListDto()
    ..attributeName = json['attributeName'] as String
    ..attributeValue = json['attributeValue'] as String;
}

Map<String, dynamic> _$CustomerRequestAttributeListDtoToJson(
        CustomerRequestAttributeListDto instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'attributeValue': instance.attributeValue
    };
