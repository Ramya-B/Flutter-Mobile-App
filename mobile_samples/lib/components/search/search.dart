import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection, where;
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:http/http.dart' as http;

class SearchItems extends StatefulWidget {
  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  var keyword;
  var prodList = [];
  bool showList = false;
  var search = {
    'pagination': {'start': 0, 'limit': "10"},
    'productPrimarySearchCondition': {'condition': "bats"},
    'criteriaWeights': [],
    'tlcriteriaWeights': [],
    'suppliercriteriaWeights': [],
    'suppliertlcriteriaWeights': [],
    'sortBy': "relevance",
    'lobSelection': null,
    'countryId': "IN",
    'channel': "B2BInternational",
    'region': "IN",
    'location': {'countryId': "IN"}
  };
  var obj = {
    "pagination": {"start": 0, "limit": "10"},
    "productPrimarySearchCondition": {"condition": "leather jackets"},
    "productFilters": {"keyValueFacets": []},
    "criteriaWeights": [],
    "tlcriteriaWeights": [],
    "suppliercriteriaWeights": [],
    "suppliertlcriteriaWeights": [],
    "sortBy": "relevance",
    "lobSelection": null,
    "countryId": "IN",
    "channel": "B2BInternational",
    "region": "IN",
    "siteCriteria": {
      "channel": "B2BInternational",
      "site": "1152f6df-91cf-4fc2-afa7-2baa63ef5429",
      "status": "Approved"
    },
    
  };
  createAlbum() async {
    final http.Response response = await http.post(
      'http://uat.tradeleaves.internal/catalog/api/products/activeProductSearch/criteria',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'productCriteria': this.obj,
      }),
    );
var data = await json.decode(response.body);
    if (response.statusCode == 200) {
      print("fetched success.....");
      print(data);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  getProdRecords() async {
    this.prodList = [];
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('keyword is' + this.keyword);
    coll = db.collection("products");
    await coll
        .find(where.match('productName', this.keyword))
        .forEach((v) => prodList.add(v));
    setState(() {
      this.prodList = prodList;
      this.showList = true;
    });
    print("after getting all records...");
    print(this.prodList);
    db.close();
  }

  @override
  void initState() {
    this.prodList = [];
    // getProdRecords();
    print("before calling....album");
    createAlbum();
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
                          getProdRecords();
                          this.showList = true;
                          print("list of products is");
                          print(this.prodList);
                        }))
              ],
            ),
          ),
          Container(
            height: 500,
            child: GridView.builder(
                itemCount: this.prodList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return SingleProduct(
                    id: this.prodList[index]['_id'],
                    productName: this.prodList[index]['productName'],
                    productDescription: this.prodList[index]
                        ['productDescription'],
                    supplierName: this.prodList[index]['supplierName'],
                    cost: this.prodList[index]['cost'],
                    imageUrl: this.prodList[index]['imageUrl'],
                    isFavourited: this.prodList[index]['isFavourited'],
                    isCarted: this.prodList[index]['isCarted'],
                    isOrdered: this.prodList[index]['isOrdered'],
                    category: this.prodList[index]['category'],
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
