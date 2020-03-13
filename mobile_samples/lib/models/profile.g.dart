// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..unVerifiedSupplierFlag = json['unVerifiedSupplierFlag'] as String
    ..disabledReason = json['disabledReason'] as String
    ..sentOtpFailedReason = json['sentOtpFailedReason'] as String
    ..isOtpSent = json['isOtpSent'] as String
    ..registeredDate = json['registeredDate'] as String
    ..partyType = json['partyType'] == null
        ? null
        : PartyType.fromJson(json['partyType'] as Map<String, dynamic>)
    ..status = json['status'] as String
    ..address = json['address'] as String
    ..telephone = (json['telephone'] as List)
        ?.map((e) =>
            e == null ? null : Telephone.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..email = (json['email'] as List)
        ?.map(
            (e) => e == null ? null : Email.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..company = json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>)
    ..person = json['person'] == null
        ? null
        : Person.fromJson(json['person'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'unVerifiedSupplierFlag': instance.unVerifiedSupplierFlag,
      'disabledReason': instance.disabledReason,
      'sentOtpFailedReason': instance.sentOtpFailedReason,
      'isOtpSent': instance.isOtpSent,
      'registeredDate': instance.registeredDate,
      'partyType': instance.partyType,
      'status': instance.status,
      'address': instance.address,
      'telephone': instance.telephone,
      'email': instance.email,
      'company': instance.company,
      'person': instance.person
    };
