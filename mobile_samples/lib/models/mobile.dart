import 'package:json_annotation/json_annotation.dart';

part 'mobile.g.dart';

@JsonSerializable()
class Mobile {
    Mobile();

    String id;
    String countryCode;
    String areaCode;
    String contactNumber;
    String contactType;
    String verified;
    
    factory Mobile.fromJson(Map<String,dynamic> json) => _$MobileFromJson(json);
    Map<String, dynamic> toJson() => _$MobileToJson(this);
}
