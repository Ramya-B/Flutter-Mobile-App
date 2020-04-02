import 'package:json_annotation/json_annotation.dart';
import "company.dart";
part 'companyRegisterResp.g.dart';

@JsonSerializable()
class CompanyRegisterResp {
    CompanyRegisterResp();

    Company company;
    
    factory CompanyRegisterResp.fromJson(Map<String,dynamic> json) => _$CompanyRegisterRespFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyRegisterRespToJson(this);
}
