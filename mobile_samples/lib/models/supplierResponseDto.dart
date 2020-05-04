import 'package:json_annotation/json_annotation.dart';
import "supplierResponseListDto.dart";
part 'supplierResponseDto.g.dart';

@JsonSerializable()
class SupplierResponseDto {
    SupplierResponseDto();

    List<SupplierResponseListDto> supplierResponseListDto;
    num totalCount;
    
    factory SupplierResponseDto.fromJson(Map<String,dynamic> json) => _$SupplierResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierResponseDtoToJson(this);
}
