import 'package:json_annotation/json_annotation.dart';
import "favouriteProductsDTO.dart";
import "productDTO.dart";
import "supplierDTO.dart";
part 'favouriteProductsListDTO.g.dart';

@JsonSerializable()
class FavouriteProductsListDTO {
    FavouriteProductsListDTO();

    FavouriteProductsDTO favouriteProductsDTO;
    ProductDTO productDTO;
    SupplierDTO supplierSearchDTO;
    
    factory FavouriteProductsListDTO.fromJson(Map<String,dynamic> json) => _$FavouriteProductsListDTOFromJson(json);
    Map<String, dynamic> toJson() => _$FavouriteProductsListDTOToJson(this);
}
