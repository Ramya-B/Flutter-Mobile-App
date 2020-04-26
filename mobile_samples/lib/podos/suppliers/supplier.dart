
/* 
class SupplierDTO{
  
  String supplierId;
  String supplierName;
  String supplierCountry;
  String supplierCity;
  String supplierStatus;
  String supplierSubscriptionType ;
  String supplierSubscriptionId ;  
  int supplierRevenue;
  String revenueCurrency;                 
  String businessType;             
  String companyType;              
  String industryType;             
  String searchable;               
  int  yearsInBusiness; 
  int noOfEmployees; 
  String userPreferredRating; 
  String tlPreferredRating; 
  var rating;

  SupplierDTO({this.supplierId, this.supplierName, this.supplierCountry,  this.supplierCity,  this.supplierStatus ,
  this.supplierSubscriptionType, this.supplierSubscriptionId, this.supplierRevenue,  this.revenueCurrency,  this.businessType,
  this.companyType, this.industryType, this.searchable,  this.yearsInBusiness,  this.noOfEmployees ,
  this.userPreferredRating, this.tlPreferredRating, this.rating });

  factory SupplierDTO.fromJson(Map<String, dynamic> json) {
    return SupplierDTO(
      supplierId: json['supplierId'] as String,
      supplierName: json['supplierName'] as String,
      supplierCountry: json['supplierCountry'] as String,
      supplierCity: json['supplierCity'] as String,
      supplierStatus: json['supplierStatus'] as String,
      supplierSubscriptionType:json['supplierSubscriptionType'] as String,
      supplierSubscriptionId:json['supplierSubscriptionId'] as String,
      supplierRevenue:json['supplierRevenue'] as int,
      revenueCurrency:json['revenueCurrency'] as String,
      businessType:json['businessType'] as String,
      companyType :json['companyType'] as String,
      industryType :json['industryType'] as String,
      searchable:json['searchable'] as String,
      yearsInBusiness:json['yearsInBusiness'] as int,
      noOfEmployees:json['noOfEmployees'] as int,
      userPreferredRating:json['userPreferredRating'] as String,
      tlPreferredRating:json['tlPreferredRating'] as String,
      rating:json['rating'],
    );
  }

} */