import 'package:json_annotation/json_annotation.dart';

part 'activeBuyRequestInputDTO.g.dart';

@JsonSerializable()
class ActiveBuyRequestInputDTO {
    ActiveBuyRequestInputDTO();

    num startIndex;
    num size;
    String lobId;
    
    factory ActiveBuyRequestInputDTO.fromJson(Map<String,dynamic> json) => _$ActiveBuyRequestInputDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ActiveBuyRequestInputDTOToJson(this);
}
