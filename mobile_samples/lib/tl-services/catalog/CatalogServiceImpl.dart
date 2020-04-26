import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'dart:convert';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServices.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';

import '../../service_locator.dart';

class CatalogServiceImpl extends CatalogServices {
  static const String apiUrl = "/catalog/api";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  UserServiceImpl get user => locator<UserServiceImpl>();
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
    )
        .then((data) {
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
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'productCriteria': productCriteria.toJson(),
      }),
    )
        .then((data) {
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
  Future getSavedCategories(String companyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getSavedCategories service....!");
    print(companyId);
    print('${Constants.envUrl}$apiUrl/categories/$companyId/savedCategory');
    return await http.get(
      '${Constants.envUrl}$apiUrl/categories/$companyId/savedCategory',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
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
  Future getLeafCategories(CategoryDetailsLobDTO categoryDetailsLobDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getLeafCategories service....!");
    print(categoryDetailsLobDTO.toJson());
    print('${Constants.envUrl}$apiUrl/categories/leafCategories/lob');
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/categories/leafCategories/lob',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'categoryDetailsLobDTO': categoryDetailsLobDTO.toJson(),
      }),
    )
        .then((data) {
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
  Future getProductAttributesByLob(
      ListCatProdAttrLoBDTO listCatProdAttrLoBDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getProductAttributesByLob service....!");
    print(listCatProdAttrLoBDTO.toJson());
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/categoryprodattr/fetchProdAttributes/byLob',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'listCatProdAttrLoBDTO': listCatProdAttrLoBDTO.toJson(),
      }),
    )
        .then((data) {
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

  @override
  Future saveProduct(ProductDTO productDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saveProduct service....!");
    // print(productDTO.toJson());
    print(jsonEncode(productDTO));
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/products/saveProduct/byLob',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'productDTO': productDTO.toJson(),
      }),
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("saveProduct resp....");
        print(res);
        for (Faqs faq in productDTO.faqs) {
          faq.name = res["productDTO"]["productId"];
          faq.active = true;
        }
        if (productDTO.faqs.length > 0) {
          user.saveFaqs(productDTO.faqs);
        }

        return res;
      } else {
        return throw Exception('falied to saveProduct ....');
      }
    });
  }

  @override
  Future getProductById(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getProductById service....!");
    print(productId);
    return await http.get(
      '${Constants.envUrl}$apiUrl/products/$productId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getProductById resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getProductById ....');
      }
    });
  }

  @override
  Future getFavourites(
      ProductSearchCriteriaDTO productSearchCriteriaDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getFavourites service....!");
    print(jsonEncode(productSearchCriteriaDTO));
    return await http
        .post(
      '${Constants.envUrl}$apiUrl/products/getFavouriteProducts/byPartyId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'productSearchCriteriaDTO': productSearchCriteriaDTO.toJson(),
      }),
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getFavourites resp....");
        print(res);

        return res;
      } else {
        return throw Exception('falied to getFavourites ....');
      }
    });
  }

  @override
  Future handleFavorites(FavouriteProductsDTO favouriteProductsDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("handleFavorites service....!");
    print(jsonEncode(favouriteProductsDTO));
    return await http.get(
      '${Constants.envUrl}$apiUrl/products/${favouriteProductsDTO.productId}/getfavouriteProduct',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("handleFavorites resp....");
        print(res);
        if (res["favouriteId"] != null) {
          http.delete(
            '${Constants.envUrl}$apiUrl/products/${res["favouriteId"]}/favouriteById',
            headers: {
              HttpHeaders.authorizationHeader:
                  "Bearer ${prefs.getString('token')}",
              'Content-type': 'application/json; charset=UTF-8'
            },
          ).then((data) {
            if (data.statusCode == 200) {
              var resp = json.decode(data.body);
              print("fav deleted....");
              print(resp);
              return resp;
            } else {
              return throw Exception('falied to getFavourites ....');
            }
          });
        } else {
          http
              .post(
            '${Constants.envUrl}$apiUrl/products/favourite/product',
            headers: {
              HttpHeaders.authorizationHeader:
                  "Bearer ${prefs.getString('token')}",
              'Content-type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, Object>{
              'favouriteProductsDTO': favouriteProductsDTO.toJson(),
            }),
          ).then((data) {
            if (data.statusCode == 200) {
              var res = json.decode(data.body);
              print("save fav resp....");
              print(res);
              return res;
            } else {
              return throw Exception(
                  'falied to save fav ....');
            }
          });
        }
        return res;
      } else {
        return throw Exception('falied to handleFavorites ....');
      }
    });
  }

  @override
  Future getFavoriteSuppliers() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getFavoriteSuppliers service....!");
    return await http.get(
      '${Constants.envUrl}$apiUrl/products/getFavourite/supplier',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getFavoriteSuppliers resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to getFavoriteSuppliers ....');
      }
    });
  }
  
}
