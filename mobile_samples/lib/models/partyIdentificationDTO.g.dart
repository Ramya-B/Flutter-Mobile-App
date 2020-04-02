// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partyIdentificationDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyIdentificationDTO _$PartyIdentificationDTOFromJson(
    Map<String, dynamic> json) {
  return PartyIdentificationDTO()
    ..partyId = json['partyId'] as String
    ..identificationAttributes = (json['identificationAttributes'] as List)
        ?.map((e) => e == null
            ? null
            : IdentificationAttributes.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PartyIdentificationDTOToJson(
        PartyIdentificationDTO instance) =>
    <String, dynamic>{
      'partyId': instance.partyId,
      'identificationAttributes': instance.identificationAttributes
    };
