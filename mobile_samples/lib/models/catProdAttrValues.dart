import 'package:json_annotation/json_annotation.dart';

part 'catProdAttrValues.g.dart';

@JsonSerializable()
class CatProdAttrValues {
    CatProdAttrValues();

    num id;
    num categoryProductAttributeId;
    String name;
    String value;
    String type;
    
    factory CatProdAttrValues.fromJson(Map<String,dynamic> json) => _$CatProdAttrValuesFromJson(json);
    Map<String, dynamic> toJson() => _$CatProdAttrValuesToJson(this);
}
