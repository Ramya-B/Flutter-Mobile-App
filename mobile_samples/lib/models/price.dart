import 'package:json_annotation/json_annotation.dart';
import "priceList.dart";
part 'price.g.dart';

@JsonSerializable()
class Price {
    Price();

    List<PriceList> priceList;
    
    factory Price.fromJson(Map<String,dynamic> json) => _$PriceFromJson(json);
    Map<String, dynamic> toJson() => _$PriceToJson(this);
}
