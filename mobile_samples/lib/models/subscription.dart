import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
    Subscription();

    bool isdefault;
    String expiryDateTime;
    String transactionId;
    String regionId;
    String lobId;
    String parentSubscriptionId;
    String subscriptionType;
    String partySubscriptionId;
    String reason;
    String status;
    String currency;
    String cost;
    String invoiceId;
    String expiryDate;
    String activatedDate;
    String subscriptionplanName;
    String subscriptionplanId;
    String partyId;
    
    factory Subscription.fromJson(Map<String,dynamic> json) => _$SubscriptionFromJson(json);
    Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
