import 'package:json_annotation/json_annotation.dart';

part 'identificationAttributesList.g.dart';

@JsonSerializable()
class IdentificationAttributesList {
    IdentificationAttributesList();

    String attributeName;
    String attributeType;
    String attributeValidation;
    bool isRequired;
    bool anyOneFilled;
    String identificationTypeId;
    String identificationGroupId;
    
    factory IdentificationAttributesList.fromJson(Map<String,dynamic> json) => _$IdentificationAttributesListFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationAttributesListToJson(this);
}
