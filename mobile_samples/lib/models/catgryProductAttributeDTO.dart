import 'package:json_annotation/json_annotation.dart';

part 'catgryProductAttributeDTO.g.dart';

@JsonSerializable()
class CatgryProductAttributeDTO {
    CatgryProductAttributeDTO();

    num categoryProductAttributeId;
    num categoryId;
    String productAttributeId;
    bool required;
    bool variant;
    num priority;
    bool archived;
    bool deleted;
    String dataType;
    String displayType;
    bool facet;
    bool sortable;
    bool searchable;
    bool inherited;
    String lobId;
    bool singleValue;
    String validation;
    String facetPriority;
    
    factory CatgryProductAttributeDTO.fromJson(Map<String,dynamic> json) => _$CatgryProductAttributeDTOFromJson(json);
    Map<String, dynamic> toJson() => _$CatgryProductAttributeDTOToJson(this);
}
