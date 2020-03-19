import 'package:json_annotation/json_annotation.dart';
import "listCatProdAttrLoBRespDTO.dart";
part 'productAttributesResp.g.dart';

@JsonSerializable()
class ProductAttributesResp {
    ProductAttributesResp();

    ListCatProdAttrLoBRespDTO listCatProdAttrLoBRespDTO;
    
    factory ProductAttributesResp.fromJson(Map<String,dynamic> json) => _$ProductAttributesRespFromJson(json);
    Map<String, dynamic> toJson() => _$ProductAttributesRespToJson(this);
}
