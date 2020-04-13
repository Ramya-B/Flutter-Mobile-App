import 'package:json_annotation/json_annotation.dart';
import "price.dart";
import "unitType.dart";
part 'productAttributeDetailDTO.g.dart';

@JsonSerializable()
class ProductAttributeDetailDTO {
    ProductAttributeDetailDTO();

    String attributeName;
    String valueType;
    bool required;
    String displayType;
    num categoryProductAttributeId;
    String productAttributeId;
    bool facet;
    bool searchable;
    bool variant;
    bool sortable;
    String fieldId;
    String value;
    String lobId;
    String prodAttrId;
    String startTime;
    String endTime;
    String selectedPeriod;
    Price price;
    UnitType unitType;
    String perUnitWeight;
    String minOrderQty;
    
    factory ProductAttributeDetailDTO.fromJson(Map<String,dynamic> json) => _$ProductAttributeDetailDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductAttributeDetailDTOToJson(this);
}
