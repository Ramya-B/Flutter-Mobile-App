import 'package:json_annotation/json_annotation.dart';
import "identificationAttributesList.dart";
part 'IdentityNumberAttributes.g.dart';

@JsonSerializable()
class IdentityNumberAttributes {
    IdentityNumberAttributes();

    List<IdentificationAttributesList> identificationAttributesList;
    
    factory IdentityNumberAttributes.fromJson(Map<String,dynamic> json) => _$IdentityNumberAttributesFromJson(json);
    Map<String, dynamic> toJson() => _$IdentityNumberAttributesToJson(this);
}
