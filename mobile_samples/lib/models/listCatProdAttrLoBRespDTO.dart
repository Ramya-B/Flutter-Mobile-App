import 'package:json_annotation/json_annotation.dart';

part 'listCatProdAttrLoBRespDTO.g.dart';

@JsonSerializable()
class ListCatProdAttrLoBRespDTO {
    ListCatProdAttrLoBRespDTO();

    Map<String,dynamic> listCatProdAttrLoBRespDTO;
    
    factory ListCatProdAttrLoBRespDTO.fromJson(Map<String,dynamic> json) => _$ListCatProdAttrLoBRespDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ListCatProdAttrLoBRespDTOToJson(this);
}
