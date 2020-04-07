import 'package:json_annotation/json_annotation.dart';

part 'productPriceSlabs.g.dart';

@JsonSerializable()
class ProductPriceSlabs {
    ProductPriceSlabs();

    String price;
    String rangeStart;
    
    factory ProductPriceSlabs.fromJson(Map<String,dynamic> json) => _$ProductPriceSlabsFromJson(json);
    Map<String, dynamic> toJson() => _$ProductPriceSlabsToJson(this);
}
