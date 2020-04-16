import 'package:json_annotation/json_annotation.dart';

part 'deliveryScheduleDTO.g.dart';

@JsonSerializable()
class DeliveryScheduleDTO {
    DeliveryScheduleDTO();

    String deliveryScheduleId;
    num minValue;
    num maxValue;
    String incoTerms;
    String unitType;
    String attributeId;
    String attributeName;
    String lobId;
    
    factory DeliveryScheduleDTO.fromJson(Map<String,dynamic> json) => _$DeliveryScheduleDTOFromJson(json);
    Map<String, dynamic> toJson() => _$DeliveryScheduleDTOToJson(this);
}
