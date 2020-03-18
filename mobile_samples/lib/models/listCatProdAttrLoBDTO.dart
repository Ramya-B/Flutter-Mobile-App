import 'package:json_annotation/json_annotation.dart';

part 'listCatProdAttrLoBDTO.g.dart';

@JsonSerializable()
class ListCatProdAttrLoBDTO {
    ListCatProdAttrLoBDTO();

    num categoryId;
    List lobId;
    
    factory ListCatProdAttrLoBDTO.fromJson(Map<String,dynamic> json) => _$ListCatProdAttrLoBDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ListCatProdAttrLoBDTOToJson(this);
}
