import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:http/http.dart' as http;
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/podos/suppliers/supplier.dart';

class SearchItems extends StatefulWidget {
  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  var keyword;
  List<SearchResults> prodList = [];
  List<SearchResults> res = [];
  String selectedLob;
  String countryId;
  List<String> countries = <String>["IN", "US"];
  // List<Lob> lobs = <Lob>[
  //   Lob(
  //       lobId: "34343e34-7601-40de-878d-01b3bd1f0641",
  //       lobName: "Marketplace-Global"),
  //   Lob(
  //       lobId: "34343e34-7601-40de-878d-01b3bd1f0642",
  //       lobName: "Bliss-Domestic"),
  //   Lob(lobId: "34343e34-7601-40de-878d-01b3bd1f0643", lobName: "Bliss-Global"),
  //   Lob(
  //       lobId: "34343e34-7601-40de-878d-01b3bd1f0644",
  //       lobName: "Marketplace-Domestic")
  // ];

  searchProducts() async {
    ProductSearchCriteriaDTO productSearchCriteriaDTO =
        new ProductSearchCriteriaDTO();
    Pagination pagination = new Pagination(start: 0, limit: 10);
    productSearchCriteriaDTO.pagination = pagination;
    productSearchCriteriaDTO.sortBy = "relevance";
    productSearchCriteriaDTO.countryId = "IN";
    productSearchCriteriaDTO.region = "IN";
    productSearchCriteriaDTO.channel = "B2BInternational";
    ProductPrimarySearchCondition productPrimarySearchCondition =
        new ProductPrimarySearchCondition();
    productPrimarySearchCondition.condition = this.keyword;
    productSearchCriteriaDTO.productPrimarySearchCondition =
        productPrimarySearchCondition;
    SiteCriteria siteCriteria = new SiteCriteria();
    siteCriteria.channel = "B2BInternational";
    siteCriteria.site = "1152f6df-91cf-4fc2-afa7-2baa63ef5429";
    siteCriteria.status = "Approved";
    productSearchCriteriaDTO.siteCriteria = siteCriteria;
    print("productSearchCriteriaDTO1");
    print(productSearchCriteriaDTO);
    final http.Response response = await http.post(
      'http://uat.tradeleaves.internal/catalog/api/products/activeProductSearch/criteria',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'productCriteria': productSearchCriteriaDTO.toJson(),
      }),
    );
    print("response.........");
    print(response.body);
    var data = await json.decode(response.body);
    if (response.statusCode == 200) {
      print("fetched success.....");
      this.res = [];
      print(data["productDTO"]["getAllActiveProductsSupplierResponseDTO"]);
      setState(() {
        for (var i = 0;
            i <
                data["productDTO"]["getAllActiveProductsSupplierResponseDTO"]
                    .length;
            i++) {
          this.res.add(new SearchResults.fromJson(data["productDTO"]
              ["getAllActiveProductsSupplierResponseDTO"][i]));
        }
        print("fetched filter...");
        print(this.res);
        this.prodList = [];
        this.prodList = this.res;
      });
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {
    this.prodList = [];
    print("init calling....searchProducts");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
                    obscureText: false,
                    style: new TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Search...",
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (String userName) {
                      this.keyword = userName;
                      print(userName);
                    })),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search), onPressed: () => searchProducts()),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: GridView.builder(
                itemCount: this.prodList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return SingleProduct(
                    id: this.prodList[index].productDTO.productId,
                    productName: this.prodList[index].productDTO.productName,
                    productDescription: null,
                    supplierName:
                        this.prodList[index].supplierSearchDTO.supplierName,
                    cost: null,
                    imageUrl:
                        'http://uat.tradeleaves.internal/tl/public/assest/get/${this.prodList[index].productDTO.primaryImageUrl}',
                    isFavourited: false,
                    isCarted: false,
                    isOrdered: false,
                    category: this.prodList[index].productDTO.categoryId,
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}

class SearchResults {
  SupplierDTO supplierSearchDTO;
  ProductDTO productDTO;
  SearchResults({this.supplierSearchDTO, this.productDTO});

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
        supplierSearchDTO: SupplierDTO.fromJson(json['supplierSearchDTO']),
        productDTO: ProductDTO.fromJson(json['productDTO']));
  }
}



