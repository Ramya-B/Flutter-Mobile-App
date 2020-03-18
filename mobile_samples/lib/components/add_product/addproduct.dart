import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/user.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SelectCategoryRegion extends StatefulWidget {
  @override
  _SelectCategoryRegionState createState() => _SelectCategoryRegionState();
}

class _SelectCategoryRegionState extends State<SelectCategoryRegion> {
  User user;
  UserServiceImpl get userService => locator<UserServiceImpl>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  LeafResp leafCats;
  List<CategoryDTO> savedCats;
  bool response = false;
  int selectedCategory;
  bool expandFlag = false;
  getCompanyRegions() async {
    var regions = await crmService.companyRegions();
    print(regions);
  }

  prepareDataForAttr() async {
    var userdata = await userService.getUser();
    this.user = User.fromJson(userdata);
    print("getProductAttributes profile...!");
    print(this.user.toJson());
    var savedCategories =
        await catalogService.getSavedCategories(this.user.companyId.toString());
    print("getProductAttributes saved categories...!");
    print(savedCategories);
    this.savedCats = List<CategoryDTO>.from(
        savedCategories.map((i) => CategoryDTO.fromJson(i)));
    // this.savedCats =  savedCategories;
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    // categoryDetailsLobDTO.lobId =
    //     this.user.allowedlob.map((data) => data.toString()).toList();
    categoryDetailsLobDTO.lobId = [
      "34343e34-7601-40de-878d-01b3bd1f0641",
      "34343e34-7601-40de-878d-01b3bd1f0642"
    ];

    categoryDetailsLobDTO.systemRootCategoryFlag = true;
    categoryDetailsLobDTO.active = true;
    categoryDetailsLobDTO.categoryId = null;
    var leafCategories =
        await catalogService.getLeafCategories(categoryDetailsLobDTO);
    print("getProductAttributes leafCategories ...!");
    print(LeafResp.fromJson(leafCategories).toJson());
    print(leafCategories);
    this.leafCats = LeafResp.fromJson(leafCategories);
    setState(() {
      response = true;
      this.savedCats = List<CategoryDTO>.from(
          savedCategories.map((i) => CategoryDTO.fromJson(i)));
      this.leafCats = this.leafCats;
      for (int i = 0;
          i < leafCategories["categoryTreePathDto"]["childCategoryDto"].length;
          i++) {
        print(leafCategories["categoryTreePathDto"]["childCategoryDto"][i]
            ["parentCategoryName"]);
      }
    });
  }

  getProductAttributes() async {
    ListCatProdAttrLoBDTO listCatProdAttrLoBDTO = new ListCatProdAttrLoBDTO();
    listCatProdAttrLoBDTO.categoryId = this.selectedCategory;
    listCatProdAttrLoBDTO.lobId = ["34343e34-7601-40de-878d-01b3bd1f0642"];
    var prodAttr =
        await catalogService.getProductAttributesByLob(listCatProdAttrLoBDTO);
    print("getProductAttributes");
    print(prodAttr);
  }

  @override
  void initState() {
    response = false;
    prepareDataForAttr();
    getCompanyRegions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Subscribed Categories',
                style: TextStyle(fontSize: 16),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              margin: EdgeInsets.all(10),
              // padding: EdgeInsets.all(10),
              height: 400,
              child: Form(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    (this.response == true)
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: this.savedCats.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index1) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                                                          child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new IconButton(
                                              icon: new Container(
                                                child: new Icon(
                                                  expandFlag
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  expandFlag = !expandFlag;
                                                });
                                              }),
                                          Text(
                                            '${this.savedCats[index1].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  (this
                                              .leafCats
                                              .categoryTreePathDto
                                              .childCategoryDto
                                              .length >
                                          0)
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: this
                                              .leafCats
                                              .categoryTreePathDto
                                              .childCategoryDto
                                              .length,
                                          itemBuilder: (context, int index2) {
                                            return (this.savedCats[index1].id ==
                                                    this
                                                        .leafCats
                                                        .categoryTreePathDto
                                                        .childCategoryDto[
                                                            index2]
                                                        .parentCategoryId)
                                                ? Column(
                                                    children: <Widget>[
                                                      ListView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: this
                                                              .leafCats
                                                              .categoryTreePathDto
                                                              .childCategoryDto[
                                                                  index2]
                                                              .leafCategoryListDto
                                                              .length,
                                                          itemBuilder: (context,
                                                              int index3) {
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              height: 32,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                      Container(width: 60,),
                                                                  Text(
                                                                    '${this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].name}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                            // Container(
                                                            //     height: 35,
                                                            //     alignment: Alignment.topLeft,
                                                            //     decoration:
                                                            //         BoxDecoration(
                                                            //       border:
                                                            //           Border(
                                                            //         bottom: BorderSide(
                                                            //             color: Colors
                                                            //                 .grey),
                                                            //       ),
                                                            //     ),
                                                            //     child: InkWell(
                                                            //       child:
                                                            //           ListTile(
                                                            //         leading: Container(
                                                            //           alignment: Alignment.center,
                                                            //             width:
                                                            //                 20),
                                                            //         title: Text(
                                                            //           '${this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].name}',
                                                            //           style: TextStyle(
                                                            //               color: Colors
                                                            //                   .black,
                                                            //               fontSize:
                                                            //                   18),
                                                            //         ),
                                                            //       ),
                                                            //       onTap: () {
                                                            //         setState(
                                                            //             () {
                                                            //           this.selectedCategory = this
                                                            //               .leafCats
                                                            //               .categoryTreePathDto
                                                            //               .childCategoryDto[
                                                            //                   index2]
                                                            //               .leafCategoryListDto[
                                                            //                   index3]
                                                            //               .categoryId;
                                                            //         });
                                                            //       },
                                                            //     ));
                                                          })
                                                    ],
                                                  )
                                                : Container();
                                          })
                                      : Container()
                                ],
                              );
                            })
                        : Container(),
                    Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: this.user.allowedlob.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: true,
                                    onChanged: (bool value) {
                                      setState(() {});
                                    },
                                  ),
                                  Text(
                                      '${this.user.allowedlob[index].toString()}')
                                ],
                              );
                            }))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
