import 'package:json_annotation/json_annotation.dart';

part 'profileAttribute.g.dart';

@JsonSerializable()
class ProfileAttribute {
    ProfileAttribute();

    String attributeId;
    String attrName;
    String attrValue;
    String attrType;
    String attributeNameForES;
    
    factory ProfileAttribute.fromJson(Map<String,dynamic> json) => _$ProfileAttributeFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileAttributeToJson(this);
}
