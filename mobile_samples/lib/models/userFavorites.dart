import 'package:json_annotation/json_annotation.dart';
import "favouriteProductsListDTO.dart";
part 'userFavorites.g.dart';

@JsonSerializable()
class UserFavorites {
    UserFavorites();

    List<FavouriteProductsListDTO> favouriteProductsListDTO;
    
    factory UserFavorites.fromJson(Map<String,dynamic> json) => _$UserFavoritesFromJson(json);
    Map<String, dynamic> toJson() => _$UserFavoritesToJson(this);
}
