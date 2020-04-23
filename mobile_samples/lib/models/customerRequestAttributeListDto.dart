import 'package:json_annotation/json_annotation.dart';

part 'customerRequestAttributeListDto.g.dart';

@JsonSerializable()
class CustomerRequestAttributeListDto {
    CustomerRequestAttributeListDto();

    String attributeName;
    String attributeValue;
    
    factory CustomerRequestAttributeListDto.fromJson(Map<String,dynamic> json) => _$CustomerRequestAttributeListDtoFromJson(json);
    Map<String, dynamic> toJson() => _$CustomerRequestAttributeListDtoToJson(this);
}
