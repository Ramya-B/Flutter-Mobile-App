// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..provider = json['provider'] as String
    ..name = json['name'] as String
    ..hashedPassword = json['hashedPassword'] as String
    ..salt = json['salt'] as String
    ..active = json['active'] as bool
    ..emailVerified = json['emailVerified'] as bool
    ..authToken = json['authToken'] as String
    ..tenantId = json['tenantId'] as String
    ..partyId = json['partyId'] as String
    ..companyId = json['companyId'] as String
    ..personalDetails = json['personalDetails'] == null
        ? null
        : PersonalDetails.fromJson(
            json['personalDetails'] as Map<String, dynamic>)
    ..securityGroups = json['securityGroups'] == null
        ? null
        : SecurityGroups.fromJson(
            json['securityGroups'] as Map<String, dynamic>)
    ..chatCredentials = json['chatCredentials'] == null
        ? null
        : ChatCredentials.fromJson(
            json['chatCredentials'] as Map<String, dynamic>)
    ..ratingReviewCriterias = json['ratingReviewCriterias'] == null
        ? null
        : RatingReviewCriterias.fromJson(
            json['ratingReviewCriterias'] as Map<String, dynamic>)
    ..userLoggedInPortal = json['userLoggedInPortal'] as String
    ..portalType = json['portalType'] as String
    ..appsite = json['appsite'] as String
    ..modified = json['modified'] as String
    ..created = json['created'] as String
    ..allowedlob = json['allowedlob'] as List
    ..hasOrderFeature = json['hasOrderFeature'] as bool
    ..consumedBulkUploadBucket = json['consumedBulkUploadBucket'] as num
    ..allotedBulkUploadBucketUnit =
        json['allotedBulkUploadBucketUnit'] as String
    ..allotedBulkUploadBucket = json['allotedBulkUploadBucket'] as num
    ..bulkUploadKey = json['bulkUploadKey'] as String
    ..userDisabledReason = json['userDisabledReason'] as String
    ..features = json['features'] as List
    ..role = json['role'] as List;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'provider': instance.provider,
      'name': instance.name,
      'hashedPassword': instance.hashedPassword,
      'salt': instance.salt,
      'active': instance.active,
      'emailVerified': instance.emailVerified,
      'authToken': instance.authToken,
      'tenantId': instance.tenantId,
      'partyId': instance.partyId,
      'companyId': instance.companyId,
      'personalDetails': instance.personalDetails,
      'securityGroups': instance.securityGroups,
      'chatCredentials': instance.chatCredentials,
      'ratingReviewCriterias': instance.ratingReviewCriterias,
      'userLoggedInPortal': instance.userLoggedInPortal,
      'portalType': instance.portalType,
      'appsite': instance.appsite,
      'modified': instance.modified,
      'created': instance.created,
      'allowedlob': instance.allowedlob,
      'hasOrderFeature': instance.hasOrderFeature,
      'consumedBulkUploadBucket': instance.consumedBulkUploadBucket,
      'allotedBulkUploadBucketUnit': instance.allotedBulkUploadBucketUnit,
      'allotedBulkUploadBucket': instance.allotedBulkUploadBucket,
      'bulkUploadKey': instance.bulkUploadKey,
      'userDisabledReason': instance.userDisabledReason,
      'features': instance.features,
      'role': instance.role
    };
