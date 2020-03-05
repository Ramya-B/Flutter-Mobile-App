import 'package:http/http.dart' as http;
import 'package:tradeleaves/podos/categories/categories.dart';
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
  Future search(ProductSearchCriteriaDTO productSearchCriteriaDTO) async {
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
        return res;
      } else {
        return throw Exception('falied to fetch the search results....');
      }
    });
  }

  @override
  Future<List> getCategories(
      CategoryDetailsLobDTO categoryDetailsLobDTO) async {
    return await http
        .post(
      "${Constants.envUrl}${apiUrl}categories/rootCategories/withimagesByLob",
      headers: headers,
      body: jsonEncode(<String, Object>{
        'categoryDetailsLobDTO': categoryDetailsLobDTO.toJson()
      }),
    )
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

  @override
  Future<List> getPromotedProducts(
      PromoProductCriteria promoProductCriteria) async {
    return await http
        .post(
      '${Constants.envUrl}${apiUrl}products/getProducts/ByPromotionPlan',
      headers: headers,
      body: jsonEncode(<String, Object>{
        'PromotionCriteria': promoProductCriteria.toJson(),
      }),
    )
        .then((data) {
      print("promotional plan data");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("promoted products response....");
        print(res);
        return res["productsPromotionsResponseDTO"];
      } else {
        return throw Exception('falied to fetch the promoted products....');
      }
    });
  }

  Future<List> getCategoryDetailsByLoB(
      CategoryDetailsLobDTO categoryDetailsLobDTO) async {
    return await http
        .post(
      "${Constants.envUrl}${apiUrl}categories/categoryDetails/lob",
      headers: headers,
      body: jsonEncode(<String, Object>{
        'categoryDetailsLobDTO': categoryDetailsLobDTO.toJson()
      }),
    )
        .then((data) {
      if (data.statusCode == 200) {
        var response = json.decode(data.body);
        print('getCategoryDetailsByLoB called.........');
        print(response);
        return response["categoryDetailsDTO"];
      } else {
        return throw Exception('GetCategoryDetailsByLoB failed..........');
      }
    });
  }
}
