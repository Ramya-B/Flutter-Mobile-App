// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDTO _$ImageDTOFromJson(Map<String, dynamic> json) {
  return ImageDTO()
    ..imageType = json['imageType'] as String
    ..imageUrl = json['imageUrl'] as String
    ..isCoverPhoto = json['isCoverPhoto'] as bool
    ..isHide = json['isHide'] as bool
    ..lobId = json['lobId'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$ImageDTOToJson(ImageDTO instance) => <String, dynamic>{
      'imageType': instance.imageType,
      'imageUrl': instance.imageUrl,
      'isCoverPhoto': instance.isCoverPhoto,
      'isHide': instance.isHide,
      'lobId': instance.lobId,
      'name': instance.name
    };
