// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listCatProdAttrLoBDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCatProdAttrLoBDTO _$ListCatProdAttrLoBDTOFromJson(
    Map<String, dynamic> json) {
  return ListCatProdAttrLoBDTO()
    ..categoryId = json['categoryId'] as num
    ..lobId = json['lobId'] as List;
}

Map<String, dynamic> _$ListCatProdAttrLoBDTOToJson(
        ListCatProdAttrLoBDTO instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'lobId': instance.lobId
    };
