// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownerAndRoleDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerAndRoleDTO _$OwnerAndRoleDTOFromJson(Map<String, dynamic> json) {
  return OwnerAndRoleDTO()
    ..ownerParty = json['ownerParty'] == null
        ? null
        : OwnerParty.fromJson(json['ownerParty'] as Map<String, dynamic>)
    ..roleDTO = json['roleDTO'] as String
    ..telephoneDTO = json['telephoneDTO'] == null
        ? null
        : Telephone.fromJson(json['telephoneDTO'] as Map<String, dynamic>)
    ..emailContactDTO = json['emailContactDTO'] == null
        ? null
        : Email.fromJson(json['emailContactDTO'] as Map<String, dynamic>)
    ..companyPartyId = json['companyPartyId'] as String
    ..admin = json['admin'] as bool;
}

Map<String, dynamic> _$OwnerAndRoleDTOToJson(OwnerAndRoleDTO instance) =>
    <String, dynamic>{
      'ownerParty': instance.ownerParty,
      'roleDTO': instance.roleDTO,
      'telephoneDTO': instance.telephoneDTO,
      'emailContactDTO': instance.emailContactDTO,
      'companyPartyId': instance.companyPartyId,
      'admin': instance.admin
    };
