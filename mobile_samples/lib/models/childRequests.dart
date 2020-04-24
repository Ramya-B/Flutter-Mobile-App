import 'package:json_annotation/json_annotation.dart';
import "requestDTO.dart";
part 'childRequests.g.dart';

@JsonSerializable()
class ChildRequests {
    ChildRequests();

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
    List<ChildRequests> childRequests;
    
    factory ChildRequests.fromJson(Map<String,dynamic> json) => _$ChildRequestsFromJson(json);
    Map<String, dynamic> toJson() => _$ChildRequestsToJson(this);
}
