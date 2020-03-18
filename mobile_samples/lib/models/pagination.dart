import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
    Pagination();

    num start;
    num limit;
    
    factory Pagination.fromJson(Map<String,dynamic> json) => _$PaginationFromJson(json);
    Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
