import 'package:json_annotation/json_annotation.dart';
import 'package:tradeleaves/podos/products/product.dart';
part 'productCriteria.g.dart';

@JsonSerializable()
class ProductCriteria {
    ProductCriteria();

    Pagination pagination;
    List<Sort> sort;
    List siteCriterias;
    
    factory ProductCriteria.fromJson(Map<String,dynamic> json) => _$ProductCriteriaFromJson(json);
    Map<String, dynamic> toJson() => _$ProductCriteriaToJson(this);
}
