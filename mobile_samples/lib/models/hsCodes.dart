import 'package:json_annotation/json_annotation.dart';

part 'hsCodes.g.dart';

@JsonSerializable()
class HsCodes {
    HsCodes();

    String hscode;
    String countryCode;
    String direction;
    String lobId;
    
    factory HsCodes.fromJson(Map<String,dynamic> json) => _$HsCodesFromJson(json);
    Map<String, dynamic> toJson() => _$HsCodesToJson(this);
}
