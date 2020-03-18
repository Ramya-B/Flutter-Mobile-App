import 'package:json_annotation/json_annotation.dart';
import "createCategoryProductAttributeDTO.dart";
part 'catProdAttrLoBListDTO.g.dart';

@JsonSerializable()
class CatProdAttrLoBListDTO {
    CatProdAttrLoBListDTO();

    String lobId;
    List<CreateCategoryProductAttributeDTO> createCategoryProductAttributeDTO;
    
    factory CatProdAttrLoBListDTO.fromJson(Map<String,dynamic> json) => _$CatProdAttrLoBListDTOFromJson(json);
    Map<String, dynamic> toJson() => _$CatProdAttrLoBListDTOToJson(this);
}
