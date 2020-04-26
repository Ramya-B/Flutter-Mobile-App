import 'package:json_annotation/json_annotation.dart';
import "requestDTO.dart";
part 'supplierResponseListDto.g.dart';

@JsonSerializable()
class SupplierResponseListDto {
    SupplierResponseListDto();

    RequestDTO requestDto;
    bool hasResponse;
    num responseCount;
    num unreadResponseCount;
    num unreadMessageCount;
    
    factory SupplierResponseListDto.fromJson(Map<String,dynamic> json) => _$SupplierResponseListDtoFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierResponseListDtoToJson(this);
}
