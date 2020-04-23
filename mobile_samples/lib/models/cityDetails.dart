import 'package:json_annotation/json_annotation.dart';
import "location.dart";
part 'cityDetails.g.dart';

@JsonSerializable()
class CityDetails {
    CityDetails();

    String countryCode;
    String postalCode;
    String village;
    String state;
    String stateID;
    String city;
    String column_6;
    String town;
    String column_8;
    num latitude;
    num longitude;
    String column_11;
    String cityImage;
    String modified;
    String created;
    Location location;
    bool isPopular;
    bool isActive;
    
    factory CityDetails.fromJson(Map<String,dynamic> json) => _$CityDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$CityDetailsToJson(this);
}
