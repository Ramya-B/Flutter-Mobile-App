import 'package:json_annotation/json_annotation.dart';
import "imageDTO.dart";
import "productAttributeDetailDTO.dart";
import "priceList.dart";
import "deliveryScheduleDTO.dart";
part 'productOptionDTO.g.dart';

@JsonSerializable()
class ProductOptionDTO {
    ProductOptionDTO();

    String productOptionName;
    String start;
    num supplierSKUId;
    List<ImageDTO> imageDTO;
    List<ProductAttributeDetailDTO> productAttributeDetailDTO;
    List<PriceList> priceList;
    List<DeliveryScheduleDTO> deliveryScheduleDTO;
    
    factory ProductOptionDTO.fromJson(Map<String,dynamic> json) => _$ProductOptionDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductOptionDTOToJson(this);
}
