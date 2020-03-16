// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..optIn = json['optIn'] as bool
    ..tenantId = json['tenantId'] as String
    ..occupation = json['occupation'] as String
    ..existingCustomer = json['existingCustomer'] as String
    ..comments = json['comments'] as String
    ..passportExpireDate = json['passportExpireDate'] as String
    ..passportNumber = json['passportNumber'] as String
    ..socialSecurityNumber = json['socialSecurityNumber'] as String
    ..maritalStatus = json['maritalStatus'] as String
    ..mothersMaidenName = json['mothersMaidenName'] as String
    ..weight = json['weight'] as String
    ..height = json['height'] as String
    ..birthDate = json['birthDate'] as String
    ..gender = json['gender'] as String
    ..memberId = json['memberId'] as String
    ..otherLocal = json['otherLocal'] as String
    ..lastNameLocal = json['lastNameLocal'] as String
    ..middleNameLocal = json['middleNameLocal'] as String
    ..firstNameLocal = json['firstNameLocal'] as String
    ..nickname = json['nickname'] as String
    ..suffix = json['suffix'] as String
    ..personalTitle = json['personalTitle'] as String
    ..lastName = json['lastName'] as String
    ..middleName = json['middleName'] as String
    ..firstName = json['firstName'] as String
    ..salutation = json['salutation'] as String
    ..partyId = json['partyId'] as String;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'optIn': instance.optIn,
      'tenantId': instance.tenantId,
      'occupation': instance.occupation,
      'existingCustomer': instance.existingCustomer,
      'comments': instance.comments,
      'passportExpireDate': instance.passportExpireDate,
      'passportNumber': instance.passportNumber,
      'socialSecurityNumber': instance.socialSecurityNumber,
      'maritalStatus': instance.maritalStatus,
      'mothersMaidenName': instance.mothersMaidenName,
      'weight': instance.weight,
      'height': instance.height,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'memberId': instance.memberId,
      'otherLocal': instance.otherLocal,
      'lastNameLocal': instance.lastNameLocal,
      'middleNameLocal': instance.middleNameLocal,
      'firstNameLocal': instance.firstNameLocal,
      'nickname': instance.nickname,
      'suffix': instance.suffix,
      'personalTitle': instance.personalTitle,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'firstName': instance.firstName,
      'salutation': instance.salutation,
      'partyId': instance.partyId
    };
