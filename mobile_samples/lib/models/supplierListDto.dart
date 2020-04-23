import 'package:json_annotation/json_annotation.dart';

part 'supplierListDto.g.dart';

@JsonSerializable()
class SupplierListDto {
    SupplierListDto();

    String toPartyId;
    String toPartyName;
    String productId;
    String productName;
    String productLobId;
    String planUniqueId;
    num childCustRequestId;
    String custRequestDelScheduleDTO;
    
    factory SupplierListDto.fromJson(Map<String,dynamic> json) => _$SupplierListDtoFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierListDtoToJson(this);
}
