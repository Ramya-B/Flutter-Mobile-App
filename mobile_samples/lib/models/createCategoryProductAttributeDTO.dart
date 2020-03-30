import 'package:json_annotation/json_annotation.dart';
import "productAttributeDTO.dart";
import "catgryProductAttributeDTO.dart";
import "catProdAttrValues.dart";
import "catProdAttrRoles.dart";
part 'createCategoryProductAttributeDTO.g.dart';

@JsonSerializable()
class CreateCategoryProductAttributeDTO {
    CreateCategoryProductAttributeDTO();

    ProductAttributeDTO productAttributeDTO;
    CatgryProductAttributeDTO catgryProductAttributeDTO;
    List<CatProdAttrValues> catProdAttrValues;
    List<CatProdAttrRoles> catProdAttrRoles;
    
    factory CreateCategoryProductAttributeDTO.fromJson(Map<String,dynamic> json) => _$CreateCategoryProductAttributeDTOFromJson(json);
    Map<String, dynamic> toJson() => _$CreateCategoryProductAttributeDTOToJson(this);
}
