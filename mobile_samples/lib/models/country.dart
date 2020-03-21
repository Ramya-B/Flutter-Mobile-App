import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
    Country();

    String code;
    String isoAlpha3;
    String country;
    String language;
    String currency;
    String callingCode;
    bool active;
    String mobileOtpFlag;
    
    factory Country.fromJson(Map<String,dynamic> json) => _$CountryFromJson(json);
    Map<String, dynamic> toJson() => _$CountryToJson(this);
}
