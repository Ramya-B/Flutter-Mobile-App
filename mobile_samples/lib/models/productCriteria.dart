import 'package:json_annotation/json_annotation.dart';
import "pagination.dart";
import "sort.dart";
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
