// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'childCategoryDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildCategoryDto _$ChildCategoryDtoFromJson(Map<String, dynamic> json) {
  return ChildCategoryDto()
    ..parentCategoryName = json['parentCategoryName'] as String
    ..parentCategoryId = json['parentCategoryId'] as num
    ..leafCategoryListDto = (json['leafCategoryListDto'] as List)
        ?.map((e) => e == null
            ? null
            : LeafCategoryListDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ChildCategoryDtoToJson(ChildCategoryDto instance) =>
    <String, dynamic>{
      'parentCategoryName': instance.parentCategoryName,
      'parentCategoryId': instance.parentCategoryId,
      'leafCategoryListDto': instance.leafCategoryListDto
    };
