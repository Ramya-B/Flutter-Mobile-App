// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return Subscription()
    ..isdefault = json['isdefault'] as bool
    ..expiryDateTime = json['expiryDateTime'] as String
    ..transactionId = json['transactionId'] as String
    ..regionId = json['regionId'] as String
    ..lobId = json['lobId'] as String
    ..parentSubscriptionId = json['parentSubscriptionId'] as String
    ..subscriptionType = json['subscriptionType'] as String
    ..partySubscriptionId = json['partySubscriptionId'] as String
    ..reason = json['reason'] as String
    ..status = json['status'] as String
    ..currency = json['currency'] as String
    ..cost = json['cost'] as String
    ..invoiceId = json['invoiceId'] as String
    ..expiryDate = json['expiryDate'] as String
    ..activatedDate = json['activatedDate'] as String
    ..subscriptionplanName = json['subscriptionplanName'] as String
    ..subscriptionplanId = json['subscriptionplanId'] as String
    ..partyId = json['partyId'] as String;
}

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'isdefault': instance.isdefault,
      'expiryDateTime': instance.expiryDateTime,
      'transactionId': instance.transactionId,
      'regionId': instance.regionId,
      'lobId': instance.lobId,
      'parentSubscriptionId': instance.parentSubscriptionId,
      'subscriptionType': instance.subscriptionType,
      'partySubscriptionId': instance.partySubscriptionId,
      'reason': instance.reason,
      'status': instance.status,
      'currency': instance.currency,
      'cost': instance.cost,
      'invoiceId': instance.invoiceId,
      'expiryDate': instance.expiryDate,
      'activatedDate': instance.activatedDate,
      'subscriptionplanName': instance.subscriptionplanName,
      'subscriptionplanId': instance.subscriptionplanId,
      'partyId': instance.partyId
    };
