import 'package:json_annotation/json_annotation.dart';
import "productPriceSlabs.dart";
part 'priceList.g.dart';

@JsonSerializable()
class PriceList {
    PriceList();

    String currency;
    String lobId;
    String priceType;
    List<ProductPriceSlabs> productPriceSlabs;
    String unitType;
    
    factory PriceList.fromJson(Map<String,dynamic> json) => _$PriceListFromJson(json);
    Map<String, dynamic> toJson() => _$PriceListToJson(this);
}
