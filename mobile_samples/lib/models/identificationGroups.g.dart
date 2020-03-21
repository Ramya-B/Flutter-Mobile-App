// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identificationGroups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationGroups _$IdentificationGroupsFromJson(Map<String, dynamic> json) {
  return IdentificationGroups()
    ..identificationGroupId = json['identificationGroupId'] as String
    ..companyTypeId = json['companyTypeId'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..identificationTypeDTOList = (json['identificationTypeDTOList'] as List)
        ?.map((e) => e == null
            ? null
            : IdentificationTypeDTOList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IdentificationGroupsToJson(
        IdentificationGroups instance) =>
    <String, dynamic>{
      'identificationGroupId': instance.identificationGroupId,
      'companyTypeId': instance.companyTypeId,
      'name': instance.name,
      'description': instance.description,
      'identificationTypeDTOList': instance.identificationTypeDTOList
    };
