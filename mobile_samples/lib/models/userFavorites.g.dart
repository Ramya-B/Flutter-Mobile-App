// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userFavorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFavorites _$UserFavoritesFromJson(Map<String, dynamic> json) {
  return UserFavorites()
    ..favouriteProductsListDTO = (json['favouriteProductsListDTO'] as List)
        ?.map((e) => e == null
            ? null
            : FavouriteProductsListDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserFavoritesToJson(UserFavorites instance) =>
    <String, dynamic>{
      'favouriteProductsListDTO': instance.favouriteProductsListDTO
    };
