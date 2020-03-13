import 'package:json_annotation/json_annotation.dart';
import "personalDetails.dart";
import "securityGroups.dart";
import "chatCredentials.dart";
import "ratingReviewCriterias.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String provider;
    String name;
    String hashedPassword;
    String salt;
    bool active;
    bool emailVerified;
    String authToken;
    String tenantId;
    String partyId;
    String companyId;
    PersonalDetails personalDetails;
    SecurityGroups securityGroups;
    ChatCredentials chatCredentials;
    RatingReviewCriterias ratingReviewCriterias;
    String userLoggedInPortal;
    String portalType;
    String appsite;
    String modified;
    String created;
    List allowedlob;
    bool hasOrderFeature;
    num consumedBulkUploadBucket;
    String allotedBulkUploadBucketUnit;
    num allotedBulkUploadBucket;
    String bulkUploadKey;
    String userDisabledReason;
    List features;
    List role;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
