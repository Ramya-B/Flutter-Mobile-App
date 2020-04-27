import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/categories/sub_categories.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../constants.dart';

class HomeProducts extends StatefulWidget {
  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Text(
            'Top Categories',
            style: TextStyle(fontSize: 18),
          ),
          padding: EdgeInsets.all(10),
          alignment: Alignment.topLeft,
        ),
        Container(
          height: 280,
          child: HomePageCategories(),
        ),
        //  Container(
        //   child: Text(
        //     'Sponsored Ads',
        //     style: TextStyle(fontSize: 18),
        //   ),
        //   padding: EdgeInsets.all(10),
        //   alignment: Alignment.topLeft,
        // ),
        Container(
          child: FetchPromotedProducts(
            promoType: 'SponsoredAds',
          ),
        ),
        // Container(
        //   child: Text(
        //     'Highlights',
        //     style: TextStyle(fontSize: 18),
        //   ),
        //   padding: EdgeInsets.all(10),
        //   alignment: Alignment.topLeft,
        // ),
        Container(
          child: FetchPromotedProducts(
            promoType: 'TopList',
          ),
        ),
       
      ],
    );
  }
}

class HomePageCategories extends StatefulWidget {
  @override
  _HomePageCategoriesState createState() => _HomePageCategoriesState();
}

class _HomePageCategoriesState extends State<HomePageCategories> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  var categoryList = [];

  getCategories() async {
    print("getCategories called...");
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.lobId = ["34343e34-7601-40de-878d-01b3bd1f0641"];
    categoryDetailsLobDTO.systemRootCategoryFlag = false;
    categoryDetailsLobDTO.restrictFetchImage = false;
    categoryDetailsLobDTO.active = true;

    var data = await catalogService.getCategories(categoryDetailsLobDTO);
    setState(() {
      print("Categories from node...");
      print(data);
      var dup = [];
      for (var cat in data) {
        dup.add(CategoryDTO.fromJson(cat));
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
    return categoryList.length>0? GridView.builder(
        itemCount: this.categoryList.length,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return  CategoryCard(    categoryDTO: this.categoryList[index],);
        }):Center(child: CircularProgressIndicator(),);
  }
}

class CategoryCard extends StatefulWidget {
    final CategoryDTO categoryDTO;
  CategoryCard({this.categoryDTO});
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
   List<CategoryAttributeDTO> categoryAttributeDTO;
   String categoryImage ;
   @override
  void initState() {
    for (var item in widget.categoryDTO.categoryAttribute) {
      if(item.attributeName == 'ThumbnailImageAttribute'){
        this.categoryImage = '${Constants.envUrl}${Constants.mongoImageUrl}/${item.attributeValue}';
      }
    } 

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 140,
      width: 140,
      child:  InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => SubCategoryDeatils(
                     categoryDTO : widget.categoryDTO,
                     categoryImage:this.categoryImage 
                    ))),
              child: Card(
              child: Container(
                height: 120,
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    this.categoryImage!=null ? Image.network(
                    '${this.categoryImage}',
                    width: 90,
                    height: 70,
                  ):Container(),
                  Container(child:Text(widget.categoryDTO.name,style: TextStyle(color: Colors.grey),), padding: EdgeInsets.all(5),)
                  ],
                ),
              )
            ),
      ),
    );
  }
}