import 'package:json_annotation/json_annotation.dart';

part 'uomDTO.g.dart';

@JsonSerializable()
class UomDTO {
    UomDTO();

    String unit;
    String description;
    
    factory UomDTO.fromJson(Map<String,dynamic> json) => _$UomDTOFromJson(json);
    Map<String, dynamic> toJson() => _$UomDTOToJson(this);
}
