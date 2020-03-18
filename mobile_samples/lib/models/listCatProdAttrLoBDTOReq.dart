import 'package:json_annotation/json_annotation.dart';
import "listCatProdAttrLoBDTO.dart";
part 'listCatProdAttrLoBDTOReq.g.dart';

@JsonSerializable()
class ListCatProdAttrLoBDTOReq {
    ListCatProdAttrLoBDTOReq();

    ListCatProdAttrLoBDTO listCatProdAttrLoBDTO;
    
    factory ListCatProdAttrLoBDTOReq.fromJson(Map<String,dynamic> json) => _$ListCatProdAttrLoBDTOReqFromJson(json);
    Map<String, dynamic> toJson() => _$ListCatProdAttrLoBDTOReqToJson(this);
}
