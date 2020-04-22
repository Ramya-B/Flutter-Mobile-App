import 'package:json_annotation/json_annotation.dart';
import "productAttributeDetailDTO.dart";
import "productOptionDTO.dart";
import "productLobCountryStatusDTO.dart";
import "hsCodes.dart";
import "faqs.dart";
part 'productDTO.g.dart';

@JsonSerializable()
class ProductDTO {
    ProductDTO();

    List<ProductAttributeDetailDTO> productAttributeDetailDTO;
    List<ProductOptionDTO> productOptionDTO;
    List<ProductLobCountryStatusDTO> productLobCountryStatusDTO;
    String productName;
    String primaryImageUrl;
    String type;
    String channel;
    String region;
    List<HsCodes> hsCodes;
    String status;
    List categoryIds;
    List<Faqs> faqs;
    List selectedSites;
    String supplierId;
    
    factory ProductDTO.fromJson(Map<String,dynamic> json) => _$ProductDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}
