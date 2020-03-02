import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServices.dart';
import 'package:tradeleaves/constants.dart';

class CatalogServiceImpl extends CatalogServices {
  static const String apiUrl = "catalog/api/";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future<List> search(ProductSearchCriteriaDTO productSearchCriteriaDTO) async {
    return await http
        .post(
      '${Constants.envUrl}${apiUrl}products/activeProductSearch/criteria', 
      headers: headers,
      body: jsonEncode(<String, Object>{
        'productCriteria': productSearchCriteriaDTO.toJson(),
      }),
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("search results came....");
        print(res);
        return res["productDTO"]["getAllActiveProductsSupplierResponseDTO"];
      } else {
        return throw Exception('falied to fetch the search results....');
      }
    });
  }

  @override
  Future<List> getCategories() async {
    return await http
        .get("${Constants.envUrl}${apiUrl}categories/rootCategories/withimages")
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("categories came....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to fetch the categories....');
      }
    });
  }
}
