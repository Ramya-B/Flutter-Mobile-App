// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'childRequests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildRequests _$ChildRequestsFromJson(Map<String, dynamic> json) {
  return ChildRequests()
    ..requestDTO = json['requestDTO'] == null
        ? null
        : RequestDTO.fromJson(json['requestDTO'] as Map<String, dynamic>)
    ..supplierRequestCount = json['supplierRequestCount'] as num
    ..unreadResponseCount = json['unreadResponseCount'] as num
    ..hasRejectedRequests = json['hasRejectedRequests'] as bool
    ..rejectedRequestCount = json['rejectedRequestCount'] as num
    ..hasResponse = json['hasResponse'] as bool
    ..replyCount = json['replyCount'] as num
    ..hasQuote = json['hasQuote'] as bool
    ..messageReplyCount = json['messageReplyCount'] as num
    ..lastActivityTs = json['lastActivityTs'] as String
    ..childRequests = (json['childRequests'] as List)
        ?.map((e) => e == null
            ? null
            : ChildRequests.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ChildRequestsToJson(ChildRequests instance) =>
    <String, dynamic>{
      'requestDTO': instance.requestDTO,
      'supplierRequestCount': instance.supplierRequestCount,
      'unreadResponseCount': instance.unreadResponseCount,
      'hasRejectedRequests': instance.hasRejectedRequests,
      'rejectedRequestCount': instance.rejectedRequestCount,
      'hasResponse': instance.hasResponse,
      'replyCount': instance.replyCount,
      'hasQuote': instance.hasQuote,
      'messageReplyCount': instance.messageReplyCount,
      'lastActivityTs': instance.lastActivityTs,
      'childRequests': instance.childRequests
    };
