// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details()
    ..partyId = json['partyId'] as String
    ..salutation = json['salutation'] as String
    ..firstName = json['firstName'] as String
    ..middleName = json['middleName'] as String
    ..lastName = json['lastName'] as String
    ..personalTitle = json['personalTitle'] as String
    ..suffix = json['suffix'] as String
    ..nickname = json['nickname'] as String
    ..firstNameLocal = json['firstNameLocal'] as String
    ..middleNameLocal = json['middleNameLocal'] as String
    ..lastNameLocal = json['lastNameLocal'] as String
    ..otherLocal = json['otherLocal'] as String
    ..memberId = json['memberId'] as String
    ..gender = json['gender'] as String
    ..birthDate = json['birthDate'] as String
    ..height = json['height'] as String
    ..weight = json['weight'] as String
    ..mothersMaidenName = json['mothersMaidenName'] as String
    ..maritalStatus = json['maritalStatus'] as String
    ..socialSecurityNumber = json['socialSecurityNumber'] as String
    ..passportNumber = json['passportNumber'] as String
    ..passportExpireDate = json['passportExpireDate'] as String
    ..comments = json['comments'] as String
    ..existingCustomer = json['existingCustomer'] as String
    ..occupation = json['occupation'] as String
    ..tenantId = json['tenantId'] as String
    ..optIn = json['optIn'] as bool
    ..domainName = json['domainName'] as String;
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'partyId': instance.partyId,
      'salutation': instance.salutation,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'personalTitle': instance.personalTitle,
      'suffix': instance.suffix,
      'nickname': instance.nickname,
      'firstNameLocal': instance.firstNameLocal,
      'middleNameLocal': instance.middleNameLocal,
      'lastNameLocal': instance.lastNameLocal,
      'otherLocal': instance.otherLocal,
      'memberId': instance.memberId,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'height': instance.height,
      'weight': instance.weight,
      'mothersMaidenName': instance.mothersMaidenName,
      'maritalStatus': instance.maritalStatus,
      'socialSecurityNumber': instance.socialSecurityNumber,
      'passportNumber': instance.passportNumber,
      'passportExpireDate': instance.passportExpireDate,
      'comments': instance.comments,
      'existingCustomer': instance.existingCustomer,
      'occupation': instance.occupation,
      'tenantId': instance.tenantId,
      'optIn': instance.optIn,
      'domainName': instance.domainName
    };
