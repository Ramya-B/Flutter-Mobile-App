// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalDetailsDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDetailsDTO _$PersonalDetailsDTOFromJson(Map<String, dynamic> json) {
  return PersonalDetailsDTO()
    ..details = json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>)
    ..mobile = json['mobile'] == null
        ? null
        : Mobile.fromJson(json['mobile'] as Map<String, dynamic>)
    ..email = json['email'] == null
        ? null
        : Email.fromJson(json['email'] as Map<String, dynamic>)
    ..role = json['role'] as String
    ..secondaryMobile = json['secondaryMobile'] as String
    ..secondaryEmail = json['secondaryEmail'] as String
    ..registrationStatus = json['registrationStatus'] as String;
}

Map<String, dynamic> _$PersonalDetailsDTOToJson(PersonalDetailsDTO instance) =>
    <String, dynamic>{
      'details': instance.details,
      'mobile': instance.mobile,
      'email': instance.email,
      'role': instance.role,
      'secondaryMobile': instance.secondaryMobile,
      'secondaryEmail': instance.secondaryEmail,
      'registrationStatus': instance.registrationStatus
    };
