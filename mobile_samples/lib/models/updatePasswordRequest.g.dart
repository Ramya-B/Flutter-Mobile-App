// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updatePasswordRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequest _$UpdatePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return UpdatePasswordRequest()
    ..updatePasswordDto = json['updatePasswordDto'] == null
        ? null
        : UpdatePasswordDto.fromJson(
            json['updatePasswordDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdatePasswordRequestToJson(
        UpdatePasswordRequest instance) =>
    <String, dynamic>{'updatePasswordDto': instance.updatePasswordDto};
