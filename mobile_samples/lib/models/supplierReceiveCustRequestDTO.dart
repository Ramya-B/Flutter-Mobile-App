import 'package:json_annotation/json_annotation.dart';

part 'supplierReceiveCustRequestDTO.g.dart';

@JsonSerializable()
class SupplierReceiveCustRequestDTO {
    SupplierReceiveCustRequestDTO();

    num startIndex;
    num size;
    String lobId;
    
    factory SupplierReceiveCustRequestDTO.fromJson(Map<String,dynamic> json) => _$SupplierReceiveCustRequestDTOFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierReceiveCustRequestDTOToJson(this);
}
