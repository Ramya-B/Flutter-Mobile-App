import 'dart:convert';
import 'dart:ffi';
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
  var obj = {
    "pagination": {"start": 0, "limit": "10"},
    "productPrimarySearchCondition": {"condition": "music"},
    // "productFilters": {"keyValueFacets": []},
    "sortBy": "relevance",
    //  "lobSelection": null,
    "countryId": "IN",
    "channel": "B2BInternational",
    "region": "IN",
    "siteCriteria": {
      "channel": "B2BInternational",
      "site": "1152f6df-91cf-4fc2-afa7-2baa63ef5429",
      "status": "Approved"
    },
  };

  searchProducts() async {
    ProductSearchCriteriaDTO productSearchCriteriaDTO =
        new ProductSearchCriteriaDTO();
    Pagination pagination = new Pagination();
    pagination.start = 1;
    pagination.limit = 10;
    productSearchCriteriaDTO.pagination = pagination;
    productSearchCriteriaDTO.sortBy = "relevance";
    productSearchCriteriaDTO.countryId = "IN";
    productSearchCriteriaDTO.region = "IN";
    productSearchCriteriaDTO.channel = "B2BInternational";
    ProductPrimarySearchCondition productPrimarySearchCondition = new ProductPrimarySearchCondition();  
    productPrimarySearchCondition.condition = this.keyword;
    productSearchCriteriaDTO.productPrimarySearchCondition =  productPrimarySearchCondition;    
    SiteCriteria siteCriteria = new SiteCriteria();
    siteCriteria.channel = "B2BInternational";
    siteCriteria.site = "1152f6df-91cf-4fc2-afa7-2baa63ef5429";
    siteCriteria.status = "Approved";
    productSearchCriteriaDTO.siteCriteria = siteCriteria;
    print("productSearchCriteriaDTO");
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
    var data = await json.decode(response.body);
    if (response.statusCode == 200) {
      print("fetched success.....");
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
    // searchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomToolBar(),
      body: ListView(
        children: <Widget>[
          Container(),
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Search...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onChanged: (String userName) {
                          this.keyword = userName;
                          print(userName);
                        })),
                Container(
                    width: 30,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: new IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          searchProducts();
                        }))
              ],
            ),
          ),
          Row(
            children: <Widget>[
              // Expanded(
              //   child: Center(
              //     child: new DropdownButton<String>(
              //     value: this.selectedLob,
              //     hint: Text('Select Lob'),
              //     items: lobs.map((Lob lob) {
              //       return new DropdownMenuItem<String>(
              //         value: lob.lobId,
              //         child: new Text(lob.lobName),
              //       );
              //     }).toList(),
              //     onChanged: (String value) {
              //       setState(() {
              //         print(value);
              //         this.selectedLob = value;
              //       });
              //     },
              //   ),
              //   )
              // ),
              Expanded(
                  child: Center(
                child: new DropdownButton<String>(
                  value: this.countryId,
                  hint: Text('Select Country'),
                  items: <String>['IN', 'US'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      print(value);
                      this.countryId = value;
                    });
                  },
                ),
              )),
            ],
          ),
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

class Lob {
  String lobName;
  String lobId;
  Lob({this.lobId, this.lobName});
}

class ProductSearchCriteriaDTO {
  Pagination pagination;
  ProductPrimarySearchCondition productPrimarySearchCondition;
  ProductFilters productFilters;
  var sortBy;
  var lobSelection;
  var countryId;
  var channel;
  var region;
  SiteCriteria siteCriteria;
  ProductSearchCriteriaDTO({
    this.pagination,
    this.productPrimarySearchCondition,
    this.productFilters,
    this.sortBy,
    this.lobSelection,
    this.countryId,
    this.channel,
    this.region,
    this.siteCriteria,
  });

  factory ProductSearchCriteriaDTO.fromJson(Map<String, dynamic> json) {
    return ProductSearchCriteriaDTO(
      pagination: json['pagination'],
      productPrimarySearchCondition: json['productPrimarySearchCondition'],
      productFilters: json['productFilters'],
      sortBy: json['sortBy'],
      lobSelection: json['lobSelection'],
      countryId: json['countryId'],
      channel: json['channel'],
      region: json['region'],
      siteCriteria: json['siteCriteria'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pagination': pagination,
      'productPrimarySearchCondition': productPrimarySearchCondition,
      'productFilters': productFilters,
      'sortBy': sortBy,
      'lobSelection': lobSelection,
      'countryId': countryId,
      'channel': channel,
      'region': region,
      'siteCriteria': siteCriteria,
    };
  }
}

class SiteCriteria {
  var channel;
  var site;
  var status;
  SiteCriteria({this.channel, this.site, this.status});
  factory SiteCriteria.fromJson(Map<String, dynamic> json) {
    return SiteCriteria(
      channel: json['channel'] as String,
      site: json['site'] as String,
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"channel": channel, "site": site, "status": status};
  }
}

class ProductFilters {
  var keyValueFacets = [];
  ProductFilters({this.keyValueFacets});
  factory ProductFilters.fromJson(Map<String, dynamic> json) {
    return ProductFilters(
      keyValueFacets: json['keyValueFacets'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"keyValueFacets": keyValueFacets};
  }
}

class ProductPrimarySearchCondition {
  var condition;
  ProductPrimarySearchCondition({this.condition});
  factory ProductPrimarySearchCondition.fromJson(Map<String, dynamic> json) {
    return ProductPrimarySearchCondition(
      condition: json['condition'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {"condition": condition};
  }
}

class Pagination {
  var start;
  var limit;
  Pagination({this.start, this.limit});
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      start: json['channel'] as int,
      limit: json['site'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {"start": start, "limit": limit};
  }
}
