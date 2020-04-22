// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company()
    ..channel = json['channel'] as String
    ..lobId = json['lobId'] as String
    ..countryCode = json['countryCode'] as String
    ..admin = json['admin'] as bool
    ..registeredEmailAddress = json['registeredEmailAddress'] as String
    ..classifiedsStatus = json['classifiedsStatus'] as String
    ..personPartyId = json['personPartyId'] as String
    ..partyContacts = json['partyContacts'] as List
    ..ownerAndRoleDTO = (json['ownerAndRoleDTO'] as List)
        ?.map((e) => e == null
            ? null
            : OwnerAndRoleDTO.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..partyIdentificationDTO = json['partyIdentificationDTO'] == null
        ? null
        : PartyIdentificationDTO.fromJson(
            json['partyIdentificationDTO'] as Map<String, dynamic>)
    ..profileAttribute = (json['profileAttribute'] as List)
        ?.map((e) => e == null
            ? null
            : ProfileAttribute.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..accountStatus = json['accountStatus'] == null
        ? null
        : AccountStatus.fromJson(json['accountStatus'] as Map<String, dynamic>)
    ..subscription = json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription'] as Map<String, dynamic>)
    ..classifications = json['classifications'] == null
        ? null
        : Classifications.fromJson(
            json['classifications'] as Map<String, dynamic>)
    ..identifications = json['identifications'] as String
    ..email = json['email'] == null
        ? null
        : Email.fromJson(json['email'] as Map<String, dynamic>)
    ..address = json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>)
    ..telephone = json['telephone'] == null
        ? null
        : Telephone.fromJson(json['telephone'] as Map<String, dynamic>)
    ..status = json['status'] as String
    ..details = json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'channel': instance.channel,
      'lobId': instance.lobId,
      'countryCode': instance.countryCode,
      'admin': instance.admin,
      'registeredEmailAddress': instance.registeredEmailAddress,
      'classifiedsStatus': instance.classifiedsStatus,
      'personPartyId': instance.personPartyId,
      'partyContacts': instance.partyContacts,
      'ownerAndRoleDTO': instance.ownerAndRoleDTO,
      'partyIdentificationDTO': instance.partyIdentificationDTO,
      'profileAttribute': instance.profileAttribute,
      'accountStatus': instance.accountStatus,
      'subscription': instance.subscription,
      'classifications': instance.classifications,
      'identifications': instance.identifications,
      'email': instance.email,
      'address': instance.address,
      'telephone': instance.telephone,
      'status': instance.status,
      'details': instance.details
    };
