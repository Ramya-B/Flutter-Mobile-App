import 'package:json_annotation/json_annotation.dart';

part 'productLobCountryStatusDTO.g.dart';

@JsonSerializable()
class ProductLobCountryStatusDTO {
    ProductLobCountryStatusDTO();

    String productLobCountryStatusId;
    String productId;
    String lobId;
    String regionId;
    String countryId;
    String statusId;
    String reason;
    
    factory ProductLobCountryStatusDTO.fromJson(Map<String,dynamic> json) => _$ProductLobCountryStatusDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductLobCountryStatusDTOToJson(this);
}
