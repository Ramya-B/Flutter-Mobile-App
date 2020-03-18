// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leafCategoryListDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeafCategoryListDto _$LeafCategoryListDtoFromJson(Map<String, dynamic> json) {
  return LeafCategoryListDto()
    ..categoryId = json['categoryId'] as num
    ..parentId = json['parentId'] as num
    ..name = json['name'] as String
    ..path = json['path'] as String;
}

Map<String, dynamic> _$LeafCategoryListDtoToJson(
        LeafCategoryListDto instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'parentId': instance.parentId,
      'name': instance.name,
      'path': instance.path
    };
