// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catProdAttrRoles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatProdAttrRoles _$CatProdAttrRolesFromJson(Map<String, dynamic> json) {
  return CatProdAttrRoles()
    ..id = json['id'] as String
    ..categoryId = json['categoryId'] as num
    ..productAttributeId = json['productAttributeId'] as String
    ..roleTypeId = json['roleTypeId'] as String
    ..writable = json['writable'] as bool
    ..readable = json['readable'] as bool;
}

Map<String, dynamic> _$CatProdAttrRolesToJson(CatProdAttrRoles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'productAttributeId': instance.productAttributeId,
      'roleTypeId': instance.roleTypeId,
      'writable': instance.writable,
      'readable': instance.readable
    };
