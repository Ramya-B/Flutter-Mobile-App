import 'package:json_annotation/json_annotation.dart';

part 'favouriteProductsDTO.g.dart';

@JsonSerializable()
class FavouriteProductsDTO {
    FavouriteProductsDTO();

    String favouriteId;
    String partyId;
    String productId;
    String productImageUrl;
    String productName;
    String suppplierName;
    
    factory FavouriteProductsDTO.fromJson(Map<String,dynamic> json) => _$FavouriteProductsDTOFromJson(json);
    Map<String, dynamic> toJson() => _$FavouriteProductsDTOToJson(this);
}
