import 'package:json_annotation/json_annotation.dart';
import "supplierResponseDto.dart";
part 'expiredLeadsResponseDto.g.dart';

@JsonSerializable()
class ExpiredLeadsResponseDto {
    ExpiredLeadsResponseDto();

    SupplierResponseDto supplierResponseDto;
    
    factory ExpiredLeadsResponseDto.fromJson(Map<String,dynamic> json) => _$ExpiredLeadsResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$ExpiredLeadsResponseDtoToJson(this);
}
