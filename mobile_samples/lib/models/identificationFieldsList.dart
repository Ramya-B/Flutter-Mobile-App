import 'package:json_annotation/json_annotation.dart';

part 'identificationFieldsList.g.dart';

@JsonSerializable()
class IdentificationFieldsList {
    IdentificationFieldsList();

    String name;
    String validation;
    String type;
    String required;
    String verificationLink;
    
    factory IdentificationFieldsList.fromJson(Map<String,dynamic> json) => _$IdentificationFieldsListFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationFieldsListToJson(this);
}
