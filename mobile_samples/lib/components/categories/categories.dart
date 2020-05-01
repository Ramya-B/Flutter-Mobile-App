import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/categories/sub_categories.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import '../../constants.dart';
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
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: GridView.builder(
          itemCount: this.categoryList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return SingleCategory(    categoryDTO: this.categoryList[index],        );
          }),
    );
  }
}

class SingleCategory extends StatefulWidget {
  final CategoryDTO categoryDTO;
  SingleCategory({this.categoryDTO});

  @override
  _SingleCategoryState createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
   List<CategoryAttributeDTO> categoryAttributeDTO;
   String categoryImage ;
   @override
  void initState() {
    for (var item in widget.categoryDTO.categoryAttribute) {
      if(item.attributeName == 'ThumbnailImageAttribute'){
        this.categoryImage = '${Constants.envDomainUrl}${Constants.mongoImageUrl}/${item.attributeValue}';
      }
    } 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => SubCategoryDeatils(
                     categoryDTO : widget.categoryDTO,
                     categoryImage:this.categoryImage 
                    ))),
            child: Column(
              children: <Widget>[
               this.categoryImage!=null ? Image.network(
                  this.categoryImage,
                  height: 130,
                  width: 130,
                ):Container(),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.categoryDTO.name}',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                )
              ],
            )));
  }
}

