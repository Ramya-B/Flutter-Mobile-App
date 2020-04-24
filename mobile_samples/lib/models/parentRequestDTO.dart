import 'package:json_annotation/json_annotation.dart';
import "itemsListDto.dart";
part 'parentRequestDTO.g.dart';

@JsonSerializable()
class ParentRequestDTO {
    ParentRequestDTO();

    num customerRequestId;
    String customerRequestTypeId;
    String statusId;
    String fromPartyId;
    String fromPartyName;
    String toPartyId;
    String toPartyName;
    String productId;
    String productName;
    num priority;
    String customerRequestDate;
    String responseRequiredDate;
    String customerRequestName;
    String customerRequestDesc;
    String maximumAmountUOMId;
    String productStoreId;
    String salesChannelId;
    String fulfillContactMechId;
    String currencyUOMId;
    String openDateTime;
    String closedDateTime;
    String internalComment;
    String reason;
    String parentCustomerRequestId;
    String billed;
    String tenantId;
    String categoryId;
    String isRead;
    String marketPlaceRequest;
    String lobId;
    String countryCd;
    List<ItemsListDto> items;
    String supplierListDto;
    List customerRequestAttributeListDto;
    String customerRequestRoleListDto;
    String customerRequestVariantList;
    String custRequestMessageDTO;
    bool hasRejectedRequests;
    num rejectedRequestCount;
    bool calimedFromMP;
    String createdBy;
    String fromPartyUpdatedTS;
    String toPartyUpdatedTS;
    String companyCode;
    String newCustRequestId;
    String responseReqDate;
    String supplierStatus;
    bool systemSent;
    String planUniqueId;
    bool serviceRequest;
    
    factory ParentRequestDTO.fromJson(Map<String,dynamic> json) => _$ParentRequestDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ParentRequestDTOToJson(this);
}
