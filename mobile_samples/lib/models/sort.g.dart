// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sort _$SortFromJson(Map<String, dynamic> json) {
  return Sort()
    ..direction = json['direction'] as String
    ..sort = json['sort'] as String;
}

Map<String, dynamic> _$SortToJson(Sort instance) =>
    <String, dynamic>{'direction': instance.direction, 'sort': instance.sort};
