// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationTypeDTOList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationTypeDTOList _$IdentificationTypeDTOListFromJson(
    Map<String, dynamic> json) {
  return IdentificationTypeDTOList()
    ..identificationTypeId = json['identificationTypeId'] as String
    ..identificationTypeName = json['identificationTypeName'] as String
    ..identificationFieldsList = (json['identificationFieldsList'] as List)
        ?.map((e) => e == null
            ? null
            : IdentificationFieldsList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IdentificationTypeDTOListToJson(
        IdentificationTypeDTOList instance) =>
    <String, dynamic>{
      'identificationTypeId': instance.identificationTypeId,
      'identificationTypeName': instance.identificationTypeName,
      'identificationFieldsList': instance.identificationFieldsList
    };
