import 'package:json_annotation/json_annotation.dart';
import "itemsListDto.dart";
import "supplierListDto.dart";
import "custRequestMessageDTO.dart";
part 'requestDetailDto.g.dart';

@JsonSerializable()
class RequestDetailDto {
    RequestDetailDto();

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
    num parentCustomerRequestId;
    String billed;
    String tenantId;
    String categoryId;
    String isRead;
    String marketPlaceRequest;
    String lobId;
    String countryCd;
    List<ItemsListDto> items;
    List<SupplierListDto> supplierListDto;
    String customerRequestAttributeListDto;
    String customerRequestRoleListDto;
    String customerRequestVariantList;
    List<CustRequestMessageDTO> custRequestMessageDTO;
    bool hasRejectedRequests;
    String rejectedRequestCount;
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
    
    factory RequestDetailDto.fromJson(Map<String,dynamic> json) => _$RequestDetailDtoFromJson(json);
    Map<String, dynamic> toJson() => _$RequestDetailDtoToJson(this);
}
