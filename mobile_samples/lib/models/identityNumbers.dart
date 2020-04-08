import 'package:json_annotation/json_annotation.dart';

part 'identityNumbers.g.dart';

@JsonSerializable()
class IdentityNumbers {
    IdentityNumbers();

    String attributeName;
    String attributeType;
    String attributeValidation;
    bool isRequired;
    bool anyOneFilled;
    String identificationTypeId;
    
    factory IdentityNumbers.fromJson(Map<String,dynamic> json) => _$IdentityNumbersFromJson(json);
    Map<String, dynamic> toJson() => _$IdentityNumbersToJson(this);
}
