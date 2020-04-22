import 'package:json_annotation/json_annotation.dart';
import "productPriceSlabs.dart";
import "incotermDto.dart";
part 'priceList.g.dart';

@JsonSerializable()
class PriceList {
    PriceList();

    String currency;
    String lobId;
    String priceType;
    List<ProductPriceSlabs> productPriceSlabs;
    String unitType;
    String incoterms;
    bool isIncoSelected;
    String edcStart;
    String edcEnd;
    String edcSelectedTime;
    String attributeName;
    IncotermDto selectedIncoterm;
    
    factory PriceList.fromJson(Map<String,dynamic> json) => _$PriceListFromJson(json);
    Map<String, dynamic> toJson() => _$PriceListToJson(this);
}
