// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination()
    ..start = json['start'] as num
    ..limit = json['limit'] as num;
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{'start': instance.start, 'limit': instance.limit};
