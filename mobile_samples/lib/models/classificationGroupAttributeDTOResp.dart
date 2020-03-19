import 'package:json_annotation/json_annotation.dart';
import "classificationGroupAttributeDTO.dart";
part 'classificationGroupAttributeDTOResp.g.dart';

@JsonSerializable()
class ClassificationGroupAttributeDTOResp {
    ClassificationGroupAttributeDTOResp();

    List<ClassificationGroupAttributeDTO> classificationGroupAttributeDTO;
    
    factory ClassificationGroupAttributeDTOResp.fromJson(Map<String,dynamic> json) => _$ClassificationGroupAttributeDTORespFromJson(json);
    Map<String, dynamic> toJson() => _$ClassificationGroupAttributeDTORespToJson(this);
}
