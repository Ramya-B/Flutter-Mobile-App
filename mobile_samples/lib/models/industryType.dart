import 'package:json_annotation/json_annotation.dart';

part 'industryType.g.dart';

@JsonSerializable()
class IndustryType {
    IndustryType();

    String industryId;
    String name;
    String description;
    
    factory IndustryType.fromJson(Map<String,dynamic> json) => _$IndustryTypeFromJson(json);
    Map<String, dynamic> toJson() => _$IndustryTypeToJson(this);
}
