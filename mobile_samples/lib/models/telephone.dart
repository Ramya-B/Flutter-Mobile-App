import 'package:json_annotation/json_annotation.dart';

part 'telephone.g.dart';

@JsonSerializable()
class Telephone {
    Telephone();

    String verified;
    String contactType;
    String contactNumber;
    String areaCode;
    String countryCode;
    String id;
    
    factory Telephone.fromJson(Map<String,dynamic> json) => _$TelephoneFromJson(json);
    Map<String, dynamic> toJson() => _$TelephoneToJson(this);
}
