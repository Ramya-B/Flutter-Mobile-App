import 'package:json_annotation/json_annotation.dart';
import "company.dart";
part 'companyRegisterRequest.g.dart';

@JsonSerializable()
class CompanyRegisterRequest {
    CompanyRegisterRequest();

    Company companyDTO;
    
    factory CompanyRegisterRequest.fromJson(Map<String,dynamic> json) => _$CompanyRegisterRequestFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyRegisterRequestToJson(this);
}
