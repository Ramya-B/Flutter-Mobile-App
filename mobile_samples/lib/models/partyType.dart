import 'package:json_annotation/json_annotation.dart';

part 'partyType.g.dart';

@JsonSerializable()
class PartyType {
    PartyType();

    String partyType;
    
    factory PartyType.fromJson(Map<String,dynamic> json) => _$PartyTypeFromJson(json);
    Map<String, dynamic> toJson() => _$PartyTypeToJson(this);
}
