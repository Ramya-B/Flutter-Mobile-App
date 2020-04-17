import 'package:json_annotation/json_annotation.dart';

part 'productPriceSlabs.g.dart';

@JsonSerializable()
class ProductPriceSlabs {
    ProductPriceSlabs();

    String price;
    num rangeStart;
    String qtyStart;
    String qtyEnd;
    String priceStart;
    String priceEnd;
    bool isQtyError;
    
    factory ProductPriceSlabs.fromJson(Map<String,dynamic> json) => _$ProductPriceSlabsFromJson(json);
    Map<String, dynamic> toJson() => _$ProductPriceSlabsToJson(this);
}
