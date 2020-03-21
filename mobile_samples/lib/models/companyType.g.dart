// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companyType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyType _$CompanyTypeFromJson(Map<String, dynamic> json) {
  return CompanyType()
    ..companyTypeId = json['companyTypeId'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$CompanyTypeToJson(CompanyType instance) =>
    <String, dynamic>{
      'companyTypeId': instance.companyTypeId,
      'name': instance.name,
      'description': instance.description
    };
