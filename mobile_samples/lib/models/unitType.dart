import 'package:json_annotation/json_annotation.dart';

part 'unitType.g.dart';

@JsonSerializable()
class UnitType {
    UnitType();

    String unit;
    String description;
    
    factory UnitType.fromJson(Map<String,dynamic> json) => _$UnitTypeFromJson(json);
    Map<String, dynamic> toJson() => _$UnitTypeToJson(this);
}
