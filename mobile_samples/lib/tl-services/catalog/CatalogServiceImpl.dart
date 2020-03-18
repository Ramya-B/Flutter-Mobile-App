import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'dart:convert';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServices.dart';
import 'package:tradeleaves/constants.dart';

class CatalogServiceImpl extends CatalogServices {
  
  static const String apiUrl = "/catalog/api";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future search(ProductSearchCriteriaDTO productSearchCriteriaDTO) async {
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/products/activeProductSearch/criteria',
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
      "${Constants.envUrl}$apiUrl/categories/rootCategories/withimagesByLob",
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
      '${Constants.envUrl}$apiUrl/products/getProducts/ByPromotionPlan',
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
      "${Constants.envUrl}$apiUrl/categories/categoryDetails/lob",
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

  @override
  Future getProductsByCategoryId(ProductInfo productInfo) async {
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/products/categoryId/getProductInfoByCriteria',
      headers: headers,
      body: jsonEncode(<String, Object>{
        'productInfo': productInfo.toJson(),
      }),
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("products by category id....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to fetch products by category id....');
      }
    });
  }

  @override
  Future getUserProducts(ProductCriteria productCriteria) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("get user products service....!");
      print(productCriteria.toJson());
       print(productCriteria);
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/products/productSearch/criteria',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}" , 'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, Object>{
        'productCriteria': productCriteria.toJson(),
        
      }),
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("products by getUserProducts....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getUserProducts ....');
      }
    });
  }

  @override 
  Future getSavedCategories(String companyId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
      print("getSavedCategories service....!");
      print(companyId);
       print('${Constants.envUrl}$apiUrl/categories/$companyId/savedCategory');
    return await http
        .get(
      '${Constants.envUrl}$apiUrl/categories/$companyId/savedCategory',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}" , 'Content-type': 'application/json; charset=UTF-8'},
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getSavedCategories resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getSavedCategories ....');
      }
    });
  }

  @override
  Future getLeafCategories(CategoryDetailsLobDTO categoryDetailsLobDTO) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
      print("getLeafCategories service....!");
      print(categoryDetailsLobDTO.toJson());
      print('${Constants.envUrl}$apiUrl/categories/leafCategories/lob');
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/categories/leafCategories/lob',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}" , 'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, Object>{
        'categoryDetailsLobDTO': categoryDetailsLobDTO.toJson(),
      }),
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getLeafCategories resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getLeafCategories ....');
      }
    });
  }

  @override
  Future getProductAttributesByLob(ListCatProdAttrLoBDTO listCatProdAttrLoBDTO) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      print("getProductAttributesByLob service....!");
      print(listCatProdAttrLoBDTO.toJson());
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/categoryprodattr/fetchProdAttributes/byLob',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}" , 'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, Object>{
        'listCatProdAttrLoBDTO': listCatProdAttrLoBDTO.toJson(),
      }),
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getProductAttributesByLob resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getProductAttributesByLob ....');
      }
    });
  }
}
