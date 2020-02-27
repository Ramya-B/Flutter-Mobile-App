import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/CategoryProductDetails.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var categoryList = [];
  // var cats = [];
  getCategoryRecords() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('connection open mongo');
    coll = db.collection("categories");

    await coll.find().forEach((v) => categoryList.add(v));
    setState(() {
      this.categoryList = categoryList;
    });
    print("after getting all records...");
    print(categoryList);
    db.close();
  }

  getCategories() async {
    print("getCategories called...");
    http.Response response = await http.get(
        "http://uat.tradeleaves.internal/catalog/api/categories/rootCategories/withimages");

    var data = await json.decode(response.body);
    setState(() {
      print("Categories from node...");
      print(data);
      var dup = [];
      for (var cat in data) {

        List items = cat["categoryAttribute"] as List;
        for (int i = 0; i < items.length; i++) {
          if (items[i]["attributeName"] == "ThumbnailImageAttribute" &&
              items[i]["attributeValue"] != null) {
            print("image found...");
            print(items[i]["attributeValue"]);
            dup.add({'id': cat["id"], 'name': cat["name"], 'categoryImage':"http://uat.tradeleaves.internal/tl/public/assest/get/${items[i]['attributeValue']}"});
          }
        }
      }
      print("after filtering obj");
      print(dup);
      this.categoryList = dup;
    });
    
  }

  @override
  void initState() {
    getCategories();
    // getCategoryRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: GridView.builder(
          itemCount: this.categoryList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return SingleCategory(
              categoryName: this.categoryList[index]['name'],
              categoryImage : this.categoryList[index]['categoryImage'],
            );
          }),
    );
  }
}

class SingleCategory extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  SingleCategory({this.categoryName, this.categoryImage});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => CategoryProducts(
                    categoryName: categoryName, categoryImage: categoryImage))),
            child: Column(
              children: <Widget>[
              Image.network(
                  this.categoryImage,
                  height: 130,
                  width: 130,
                ),         
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${this.categoryName}',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                )
              ],
            ))        
            );
  }
}
