// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companyRegisterRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyRegisterRequest _$CompanyRegisterRequestFromJson(
    Map<String, dynamic> json) {
  return CompanyRegisterRequest()
    ..companyDTO = json['companyDTO'] == null
        ? null
        : Company.fromJson(json['companyDTO'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CompanyRegisterRequestToJson(
        CompanyRegisterRequest instance) =>
    <String, dynamic>{'companyDTO': instance.companyDTO};
