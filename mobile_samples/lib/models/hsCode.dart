import 'package:json_annotation/json_annotation.dart';

part 'hsCode.g.dart';

@JsonSerializable()
class HsCode {
    HsCode();

    String hscode;
    String countryCode;
    String direction;
    String lobId;
    
    factory HsCode.fromJson(Map<String,dynamic> json) => _$HsCodeFromJson(json);
    Map<String, dynamic> toJson() => _$HsCodeToJson(this);
}
