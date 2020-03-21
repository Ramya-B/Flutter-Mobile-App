import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/suppliers/supplier.dart';

class SearchResults {
  SupplierDTO supplierSearchDTO;
  ProductDTO productDTO;
  SearchResults({this.supplierSearchDTO, this.productDTO});

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
        supplierSearchDTO: SupplierDTO.fromJson(json['supplierSearchDTO']) == null ? null : SupplierDTO.fromJson(json['supplierSearchDTO']),
        productDTO:  ProductDTO.fromJson(json['productDTO']) == null ? null :  ProductDTO.fromJson(json['productDTO'])
        );
  }
}