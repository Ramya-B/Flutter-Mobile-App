import 'package:json_annotation/json_annotation.dart';

part 'keyValueFacets.g.dart';

@JsonSerializable()
class KeyValueFacets {
    KeyValueFacets();

    String name;
    bool productOption;
    String type;
    bool value;
    
    factory KeyValueFacets.fromJson(Map<String,dynamic> json) => _$KeyValueFacetsFromJson(json);
    Map<String, dynamic> toJson() => _$KeyValueFacetsToJson(this);
}
