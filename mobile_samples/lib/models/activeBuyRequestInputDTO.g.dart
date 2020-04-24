// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activeBuyRequestInputDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveBuyRequestInputDTO _$ActiveBuyRequestInputDTOFromJson(
    Map<String, dynamic> json) {
  return ActiveBuyRequestInputDTO()
    ..startIndex = json['startIndex'] as num
    ..size = json['size'] as num
    ..lobId = json['lobId'] as String;
}

Map<String, dynamic> _$ActiveBuyRequestInputDTOToJson(
        ActiveBuyRequestInputDTO instance) =>
    <String, dynamic>{
      'startIndex': instance.startIndex,
      'size': instance.size,
      'lobId': instance.lobId
    };
