import 'package:json_annotation/json_annotation.dart';
import "supplierResponseListDto.dart";
part 'leadsResponseDto.g.dart';

@JsonSerializable()
class LeadsResponseDto {
    LeadsResponseDto();

    List<SupplierResponseListDto> supplierResponseListDto;
    num totalCount;
    
    factory LeadsResponseDto.fromJson(Map<String,dynamic> json) => _$LeadsResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$LeadsResponseDtoToJson(this);
}
