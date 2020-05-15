import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
    Location();

    List coordinates;
    String type;
    String countryId;
    
    factory Location.fromJson(Map<String,dynamic> json) => _$LocationFromJson(json);
    Map<String, dynamic> toJson() => _$LocationToJson(this);
}
