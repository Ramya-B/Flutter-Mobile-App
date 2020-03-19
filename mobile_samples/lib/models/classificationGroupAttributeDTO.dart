import 'package:json_annotation/json_annotation.dart';

part 'classificationGroupAttributeDTO.g.dart';

@JsonSerializable()
class ClassificationGroupAttributeDTO {
    ClassificationGroupAttributeDTO();

    String attributeId;
    String attributeName;
    String attributeDescription;
    String groupId;
    String parentAttributeId;
    bool isChecked;
    
    factory ClassificationGroupAttributeDTO.fromJson(Map<String,dynamic> json) => _$ClassificationGroupAttributeDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ClassificationGroupAttributeDTOToJson(this);
}
