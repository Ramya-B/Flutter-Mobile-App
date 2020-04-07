import 'package:json_annotation/json_annotation.dart';

part 'incotermDto.g.dart';

@JsonSerializable()
class IncotermDto {
    IncotermDto();

    String incoterm;
    String description;
    String modeOfTransport;
    String infoText;
    bool system;
    String version;
    
    factory IncotermDto.fromJson(Map<String,dynamic> json) => _$IncotermDtoFromJson(json);
    Map<String, dynamic> toJson() => _$IncotermDtoToJson(this);
}
