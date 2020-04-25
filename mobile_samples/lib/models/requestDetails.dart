import 'package:json_annotation/json_annotation.dart';
import "requestDTO.dart";
part 'requestDetails.g.dart';

@JsonSerializable()
class RequestDetails {
    RequestDetails();

    RequestDTO requestDTO;
    num supplierRequestCount;
    num unreadResponseCount;
    bool hasRejectedRequests;
    num rejectedRequestCount;
    bool hasResponse;
    num replyCount;
    bool hasQuote;
    num messageReplyCount;
    String lastActivityTs;
    List<RequestDetails> childRequests;
    bool hasChildRequestsResponse;
    bool hasChildRequests;
    bool hasIgnoredRequests;
    
    factory RequestDetails.fromJson(Map<String,dynamic> json) => _$RequestDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$RequestDetailsToJson(this);
}
