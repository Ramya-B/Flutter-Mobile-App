import 'package:json_annotation/json_annotation.dart';

part 'sort.g.dart';

@JsonSerializable()
class Sort {
    Sort();

    String direction;
    String sort;
    
    factory Sort.fromJson(Map<String,dynamic> json) => _$SortFromJson(json);
    Map<String, dynamic> toJson() => _$SortToJson(this);
}
