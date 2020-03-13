// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company()
    ..admin = json['admin'] as bool
    ..registeredEmailAddress = json['registeredEmailAddress'] as String
    ..classifiedsStatus = json['classifiedsStatus'] as String
    ..personPartyId = json['personPartyId'] as String
    ..partyContacts = json['partyContacts'] as String
    ..ownerAndRoleDTO = json['ownerAndRoleDTO'] as String
    ..partyIdentificationDTO = json['partyIdentificationDTO'] as String
    ..profileAttribute = json['profileAttribute'] as String
    ..accountStatus = json['accountStatus'] as String
    ..subscription = json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription'] as Map<String, dynamic>)
    ..classifications = json['classifications'] as String
    ..identifications = json['identifications'] as String
    ..email = json['email'] as String
    ..address = json['address'] as String
    ..telephone = json['telephone'] as String
    ..status = json['status'] as String
    ..details = json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
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
