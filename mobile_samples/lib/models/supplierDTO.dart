import 'package:json_annotation/json_annotation.dart';

part 'supplierDTO.g.dart';

@JsonSerializable()
class SupplierDTO {
    SupplierDTO();

    String businessType;
    String companyType;
    String industryType;
    num noOfEmployees;
    num rating;
    String revenueCurrency;
    String searchable;
    String supplierCity;
    String supplierCountry;
    String supplierId;
    String supplierName;
    num supplierRevenue;
    String supplierStatus;
    String supplierSubscriptionId;
    String supplierSubscriptionType;
    String tlPreferredRating;
    String userPreferredRating;
    num yearsInBusiness;
    
    factory SupplierDTO.fromJson(Map<String,dynamic> json) => _$SupplierDTOFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierDTOToJson(this);
}
