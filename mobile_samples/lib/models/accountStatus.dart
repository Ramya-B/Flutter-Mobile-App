import 'package:json_annotation/json_annotation.dart';

part 'accountStatus.g.dart';

@JsonSerializable()
class AccountStatus {
    AccountStatus();

    String companyId;
    String reason;
    String rejected;
    String statusOn;
    String statusId;
    
    factory AccountStatus.fromJson(Map<String,dynamic> json) => _$AccountStatusFromJson(json);
    Map<String, dynamic> toJson() => _$AccountStatusToJson(this);
}
