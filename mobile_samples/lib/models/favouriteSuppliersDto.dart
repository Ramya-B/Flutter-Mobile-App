import 'package:json_annotation/json_annotation.dart';
import "supplierDTO.dart";
part 'favouriteSuppliersDto.g.dart';

@JsonSerializable()
class FavouriteSuppliersDto {
    FavouriteSuppliersDto();

    String accountStatus;
    SupplierDTO detailDTO;
    String favouriteId;
    String partyId;
    num priority;
    String supplierId;
    String supplierName;
    
    factory FavouriteSuppliersDto.fromJson(Map<String,dynamic> json) => _$FavouriteSuppliersDtoFromJson(json);
    Map<String, dynamic> toJson() => _$FavouriteSuppliersDtoToJson(this);
}
