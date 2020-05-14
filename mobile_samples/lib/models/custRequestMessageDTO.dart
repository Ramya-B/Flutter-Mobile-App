import 'package:json_annotation/json_annotation.dart';

part 'custRequestMessageDTO.g.dart';

@JsonSerializable()
class CustRequestMessageDTO {
    CustRequestMessageDTO();

    String custRequestMessageId;
    num custRequestId;
    String custResponseId;
    String fromPartyId;
    String toPartyId;
    String message;
    String readStatus;
    String createdDate;
    bool supplierFlag;
    String messageAttachment;
    
    factory CustRequestMessageDTO.fromJson(Map<String,dynamic> json) => _$CustRequestMessageDTOFromJson(json);
    Map<String, dynamic> toJson() => _$CustRequestMessageDTOToJson(this);
}
