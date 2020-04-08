import 'package:json_annotation/json_annotation.dart';
import "identificationAttributesList.dart";
part 'IdentityNumberAttributesList.g.dart';

@JsonSerializable()
class IdentityNumberAttributesList {
    IdentityNumberAttributesList();

    List<IdentificationAttributesList> identificationAttributesList;
    
    factory IdentityNumberAttributesList.fromJson(Map<String,dynamic> json) => _$IdentityNumberAttributesListFromJson(json);
    Map<String, dynamic> toJson() => _$IdentityNumberAttributesListToJson(this);
}
