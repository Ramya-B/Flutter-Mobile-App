class SupplierDTO{
  
  String supplierId;
  String supplierName;
  String supplierCountry;
  String supplierCity;
  String supplierStatus;

  SupplierDTO({this.supplierId, this.supplierName, this.supplierCountry,  this.supplierCity,  this.supplierStatus });

  factory SupplierDTO.fromJson(Map<String, dynamic> json) {
    return SupplierDTO(
      supplierId: json['supplierId'] as String,
      supplierName: json['supplierName'] as String,
      supplierCountry: json['supplierCountry'] as String,
      supplierCity: json['supplierCity'] as String,
      supplierStatus: json['supplierStatus'] as String,
    );
  }

}