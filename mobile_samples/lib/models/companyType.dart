import 'package:json_annotation/json_annotation.dart';

part 'companyType.g.dart';

@JsonSerializable()
class CompanyType {
    CompanyType();

    String companyTypeId;
    String name;
    String description;
    
    factory CompanyType.fromJson(Map<String,dynamic> json) => _$CompanyTypeFromJson(json);
    Map<String, dynamic> toJson() => _$CompanyTypeToJson(this);
}
