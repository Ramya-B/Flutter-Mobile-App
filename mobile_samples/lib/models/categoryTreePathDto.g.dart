// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryTreePathDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryTreePathDto _$CategoryTreePathDtoFromJson(Map<String, dynamic> json) {
  return CategoryTreePathDto()
    ..childCategoryDto = (json['childCategoryDto'] as List)
        ?.map((e) => e == null
            ? null
            : ChildCategoryDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryTreePathDtoToJson(
        CategoryTreePathDto instance) =>
    <String, dynamic>{'childCategoryDto': instance.childCategoryDto};
