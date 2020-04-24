// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parentRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentRequestDTO _$ParentRequestDTOFromJson(Map<String, dynamic> json) {
  return ParentRequestDTO()
    ..customerRequestId = json['customerRequestId'] as num
    ..customerRequestTypeId = json['customerRequestTypeId'] as String
    ..statusId = json['statusId'] as String
    ..fromPartyId = json['fromPartyId'] as String
    ..fromPartyName = json['fromPartyName'] as String
    ..toPartyId = json['toPartyId'] as String
    ..toPartyName = json['toPartyName'] as String
    ..productId = json['productId'] as String
    ..productName = json['productName'] as String
    ..priority = json['priority'] as num
    ..customerRequestDate = json['customerRequestDate'] as String
    ..responseRequiredDate = json['responseRequiredDate'] as String
    ..customerRequestName = json['customerRequestName'] as String
    ..customerRequestDesc = json['customerRequestDesc'] as String
    ..maximumAmountUOMId = json['maximumAmountUOMId'] as String
    ..productStoreId = json['productStoreId'] as String
    ..salesChannelId = json['salesChannelId'] as String
    ..fulfillContactMechId = json['fulfillContactMechId'] as String
    ..currencyUOMId = json['currencyUOMId'] as String
    ..openDateTime = json['openDateTime'] as String
    ..closedDateTime = json['closedDateTime'] as String
    ..internalComment = json['internalComment'] as String
    ..reason = json['reason'] as String
    ..parentCustomerRequestId = json['parentCustomerRequestId'] as String
    ..billed = json['billed'] as String
    ..tenantId = json['tenantId'] as String
    ..categoryId = json['categoryId'] as String
    ..isRead = json['isRead'] as String
    ..marketPlaceRequest = json['marketPlaceRequest'] as String
    ..lobId = json['lobId'] as String
    ..countryCd = json['countryCd'] as String
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemsListDto.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..supplierListDto = json['supplierListDto'] as String
    ..customerRequestAttributeListDto =
        json['customerRequestAttributeListDto'] as List
    ..customerRequestRoleListDto = json['customerRequestRoleListDto'] as String
    ..customerRequestVariantList = json['customerRequestVariantList'] as String
    ..custRequestMessageDTO = json['custRequestMessageDTO'] as String
    ..hasRejectedRequests = json['hasRejectedRequests'] as bool
    ..rejectedRequestCount = json['rejectedRequestCount'] as num
    ..calimedFromMP = json['calimedFromMP'] as bool
    ..createdBy = json['createdBy'] as String
    ..fromPartyUpdatedTS = json['fromPartyUpdatedTS'] as String
    ..toPartyUpdatedTS = json['toPartyUpdatedTS'] as String
    ..companyCode = json['companyCode'] as String
    ..newCustRequestId = json['newCustRequestId'] as String
    ..responseReqDate = json['responseReqDate'] as String
    ..supplierStatus = json['supplierStatus'] as String
    ..systemSent = json['systemSent'] as bool
    ..planUniqueId = json['planUniqueId'] as String
    ..serviceRequest = json['serviceRequest'] as bool;
}

Map<String, dynamic> _$ParentRequestDTOToJson(ParentRequestDTO instance) =>
    <String, dynamic>{
      'customerRequestId': instance.customerRequestId,
      'customerRequestTypeId': instance.customerRequestTypeId,
      'statusId': instance.statusId,
      'fromPartyId': instance.fromPartyId,
      'fromPartyName': instance.fromPartyName,
      'toPartyId': instance.toPartyId,
      'toPartyName': instance.toPartyName,
      'productId': instance.productId,
      'productName': instance.productName,
      'priority': instance.priority,
      'customerRequestDate': instance.customerRequestDate,
      'responseRequiredDate': instance.responseRequiredDate,
      'customerRequestName': instance.customerRequestName,
      'customerRequestDesc': instance.customerRequestDesc,
      'maximumAmountUOMId': instance.maximumAmountUOMId,
      'productStoreId': instance.productStoreId,
      'salesChannelId': instance.salesChannelId,
      'fulfillContactMechId': instance.fulfillContactMechId,
      'currencyUOMId': instance.currencyUOMId,
      'openDateTime': instance.openDateTime,
      'closedDateTime': instance.closedDateTime,
      'internalComment': instance.internalComment,
      'reason': instance.reason,
      'parentCustomerRequestId': instance.parentCustomerRequestId,
      'billed': instance.billed,
      'tenantId': instance.tenantId,
      'categoryId': instance.categoryId,
      'isRead': instance.isRead,
      'marketPlaceRequest': instance.marketPlaceRequest,
      'lobId': instance.lobId,
      'countryCd': instance.countryCd,
      'items': instance.items,
      'supplierListDto': instance.supplierListDto,
      'customerRequestAttributeListDto':
          instance.customerRequestAttributeListDto,
      'customerRequestRoleListDto': instance.customerRequestRoleListDto,
      'customerRequestVariantList': instance.customerRequestVariantList,
      'custRequestMessageDTO': instance.custRequestMessageDTO,
      'hasRejectedRequests': instance.hasRejectedRequests,
      'rejectedRequestCount': instance.rejectedRequestCount,
      'calimedFromMP': instance.calimedFromMP,
      'createdBy': instance.createdBy,
      'fromPartyUpdatedTS': instance.fromPartyUpdatedTS,
      'toPartyUpdatedTS': instance.toPartyUpdatedTS,
      'companyCode': instance.companyCode,
      'newCustRequestId': instance.newCustRequestId,
      'responseReqDate': instance.responseReqDate,
      'supplierStatus': instance.supplierStatus,
      'systemSent': instance.systemSent,
      'planUniqueId': instance.planUniqueId,
      'serviceRequest': instance.serviceRequest
    };
