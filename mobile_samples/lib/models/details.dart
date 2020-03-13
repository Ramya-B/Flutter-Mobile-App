import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
    Details();

    String reason;
    String rejected;
    String channel;
    String lobId;
    String countryCode;
    String companyCode;
    String tenantId;
    String logoImageUrl;
    String comments;
    String tickerSymbol;
    String numEmployees;
    String annualRevenue;
    String officeSiteName;
    String groupNameLocal;
    String groupName;
    String partyId;
    
    factory Details.fromJson(Map<String,dynamic> json) => _$DetailsFromJson(json);
    Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
