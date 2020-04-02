import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
    Address();

    String id;
    String name;
    String address1;
    String address2;
    String state;
    String city;
    String country;
    String postalcode;
    String contactType;
    String contactTypeDescription;
    String verified;
    
    factory Address.fromJson(Map<String,dynamic> json) => _$AddressFromJson(json);
    Map<String, dynamic> toJson() => _$AddressToJson(this);
}
