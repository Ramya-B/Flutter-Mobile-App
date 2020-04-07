// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incotermDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncotermDto _$IncotermDtoFromJson(Map<String, dynamic> json) {
  return IncotermDto()
    ..incoterm = json['incoterm'] as String
    ..description = json['description'] as String
    ..modeOfTransport = json['modeOfTransport'] as String
    ..infoText = json['infoText'] as String
    ..system = json['system'] as bool
    ..version = json['version'] as String;
}

Map<String, dynamic> _$IncotermDtoToJson(IncotermDto instance) =>
    <String, dynamic>{
      'incoterm': instance.incoterm,
      'description': instance.description,
      'modeOfTransport': instance.modeOfTransport,
      'infoText': instance.infoText,
      'system': instance.system,
      'version': instance.version
    };
