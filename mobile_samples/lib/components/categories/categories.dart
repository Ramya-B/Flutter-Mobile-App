import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/products/CategoryProductDetails.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import '../../service_locator.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  var categoryList = [];

  getCategories() async {
    print("getCategories called...");
    var data = await catalogService.getCategories();
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
            dup.add({
              'id': cat["id"],
              'name': cat["name"],
              'categoryImage':
                  "http://uat.tradeleaves.internal/tl/public/assest/get/${items[i]['attributeValue']}"
            });
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
              categoryImage: this.categoryList[index]['categoryImage'],
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
            )));
  }
}
