// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDetails _$RequestDetailsFromJson(Map<String, dynamic> json) {
  return RequestDetails()
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
            : RequestDetails.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..hasChildRequestsResponse = json['hasChildRequestsResponse'] as bool
    ..hasChildRequests = json['hasChildRequests'] as bool;
}

Map<String, dynamic> _$RequestDetailsToJson(RequestDetails instance) =>
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
      'childRequests': instance.childRequests,
      'hasChildRequestsResponse': instance.hasChildRequestsResponse,
      'hasChildRequests': instance.hasChildRequests
    };
