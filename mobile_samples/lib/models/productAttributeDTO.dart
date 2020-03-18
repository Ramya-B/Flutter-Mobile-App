import 'package:json_annotation/json_annotation.dart';

part 'productAttributeDTO.g.dart';

@JsonSerializable()
class ProductAttributeDTO {
    ProductAttributeDTO();

    String productAttributeId;
    String name;
    String description;
    bool archived;
    bool deletable;
    
    factory ProductAttributeDTO.fromJson(Map<String,dynamic> json) => _$ProductAttributeDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductAttributeDTOToJson(this);
}
