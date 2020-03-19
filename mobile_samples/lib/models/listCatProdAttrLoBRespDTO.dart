import 'package:json_annotation/json_annotation.dart';
import "createCategoryProductAttributeDTO.dart";
import "catProdAttrLoBListDTO.dart";
part 'listCatProdAttrLoBRespDTO.g.dart';

@JsonSerializable()
class ListCatProdAttrLoBRespDTO {
    ListCatProdAttrLoBRespDTO();

    List<CreateCategoryProductAttributeDTO> createCategoryProductAttributeDTO;
    List<CatProdAttrLoBListDTO> catProdAttrLoBListDTO;
    
    factory ListCatProdAttrLoBRespDTO.fromJson(Map<String,dynamic> json) => _$ListCatProdAttrLoBRespDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ListCatProdAttrLoBRespDTOToJson(this);
}
