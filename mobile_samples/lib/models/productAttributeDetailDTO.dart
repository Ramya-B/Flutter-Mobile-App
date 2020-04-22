import 'package:json_annotation/json_annotation.dart';
import "price.dart";
import "unitType.dart";
import "catProdAttrValues.dart";
import "country.dart";
import "uomDTO.dart";
import "incotermDto.dart";
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
    List valuesList;
    String currency;
    CatProdAttrValues catProdAttrValue;
    Country country;
    UomDTO uom;
    IncotermDto incoterm;
    String attributeId;
    String selectedItem;
    
    factory ProductAttributeDetailDTO.fromJson(Map<String,dynamic> json) => _$ProductAttributeDetailDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductAttributeDetailDTOToJson(this);
}
