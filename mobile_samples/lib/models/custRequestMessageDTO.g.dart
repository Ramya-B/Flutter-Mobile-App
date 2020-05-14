// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custRequestMessageDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustRequestMessageDTO _$CustRequestMessageDTOFromJson(
    Map<String, dynamic> json) {
  return CustRequestMessageDTO()
    ..custRequestMessageId = json['custRequestMessageId'] as String
    ..custRequestId = json['custRequestId'] as num
    ..custResponseId = json['custResponseId'] as String
    ..fromPartyId = json['fromPartyId'] as String
    ..toPartyId = json['toPartyId'] as String
    ..message = json['message'] as String
    ..readStatus = json['readStatus'] as String
    ..createdDate = json['createdDate'] as String
    ..supplierFlag = json['supplierFlag'] as bool
    ..messageAttachment = json['messageAttachment'] as String;
}

Map<String, dynamic> _$CustRequestMessageDTOToJson(
        CustRequestMessageDTO instance) =>
    <String, dynamic>{
      'custRequestMessageId': instance.custRequestMessageId,
      'custRequestId': instance.custRequestId,
      'custResponseId': instance.custResponseId,
      'fromPartyId': instance.fromPartyId,
      'toPartyId': instance.toPartyId,
      'message': instance.message,
      'readStatus': instance.readStatus,
      'createdDate': instance.createdDate,
      'supplierFlag': instance.supplierFlag,
      'messageAttachment': instance.messageAttachment
    };
