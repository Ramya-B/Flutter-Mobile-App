import 'package:json_annotation/json_annotation.dart';

part 'catProdAttrRoles.g.dart';

@JsonSerializable()
class CatProdAttrRoles {
    CatProdAttrRoles();

    String id;
    num categoryId;
    String productAttributeId;
    String roleTypeId;
    bool writable;
    bool readable;
    
    factory CatProdAttrRoles.fromJson(Map<String,dynamic> json) => _$CatProdAttrRolesFromJson(json);
    Map<String, dynamic> toJson() => _$CatProdAttrRolesToJson(this);
}
