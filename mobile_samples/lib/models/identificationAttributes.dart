import 'package:json_annotation/json_annotation.dart';

part 'identificationAttributes.g.dart';

@JsonSerializable()
class IdentificationAttributes {
    IdentificationAttributes();

    String identificationGroupId;
    String identificationTypeId;
    String attributeName;
    String attributeValue;
    String fromDate;
    String throughDate;
    String verified;
    String verifiedDate;
    String verificationTypeId;
    String verifiedBy;
    String verifiedLink;
    
    factory IdentificationAttributes.fromJson(Map<String,dynamic> json) => _$IdentificationAttributesFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationAttributesToJson(this);
}
