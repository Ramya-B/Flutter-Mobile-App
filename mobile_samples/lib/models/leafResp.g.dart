// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leafResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeafResp _$LeafRespFromJson(Map<String, dynamic> json) {
  return LeafResp()
    ..categoryTreePathDto = json['categoryTreePathDto'] == null
        ? null
        : CategoryTreePathDto.fromJson(
            json['categoryTreePathDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LeafRespToJson(LeafResp instance) =>
    <String, dynamic>{'categoryTreePathDto': instance.categoryTreePathDto};
