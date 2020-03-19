// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classificationGroupAttributeDTOResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationGroupAttributeDTOResp
    _$ClassificationGroupAttributeDTORespFromJson(Map<String, dynamic> json) {
  return ClassificationGroupAttributeDTOResp()
    ..classificationGroupAttributeDTO =
        (json['classificationGroupAttributeDTO'] as List)
            ?.map((e) => e == null
                ? null
                : ClassificationGroupAttributeDTO.fromJson(
                    e as Map<String, dynamic>))
            ?.toList();
}

Map<String, dynamic> _$ClassificationGroupAttributeDTORespToJson(
        ClassificationGroupAttributeDTOResp instance) =>
    <String, dynamic>{
      'classificationGroupAttributeDTO':
          instance.classificationGroupAttributeDTO
    };
