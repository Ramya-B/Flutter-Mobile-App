import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/add_product/select_category_region.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import '../../constants.dart';
import '../../service_locator.dart';

class ManageCategories extends StatefulWidget {
  final User user;
  final List<CategoryDTO> savedCategories;
  ManageCategories({this.user, this.savedCategories});
  @override
  _ManageCategoriesState createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  List<CategoryDTO> categoryList = [];
  bool isSelected = false;
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  @override
  void initState() {
    getRootCategories();
    super.initState();
  }

  saveCategories() async{
    print("saved categories...!");
    var data = await catalogService.saveCategories(widget.savedCategories);
    print("Categories saved");
     Navigator.push(
            context, MaterialPageRoute(builder: (context) => SelectCategoryRegion()));
  }

  getRootCategories() async {
    print("getCategories called...");
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.lobId = widget.user.allowedlob;
    categoryDetailsLobDTO.systemRootCategoryFlag = true;
    categoryDetailsLobDTO.restrictFetchImage = false;
    categoryDetailsLobDTO.active = true;
    categoryDetailsLobDTO.fromAllowedlobs = true;
    var data = await catalogService.getCategories(categoryDetailsLobDTO);

    this.categoryList =
        List<CategoryDTO>.from(data.map((i) => CategoryDTO.fromJson(i)))
            .toList();
    if (widget.savedCategories != null && widget.savedCategories.length > 0) {
      for (var saved in widget.savedCategories) {
        if (this.categoryList.length > 0) {
          for (var item in this.categoryList) {
            if (saved.id == item.id) {
              item.isExpanded = false;
              break;
            }
          }
        }
      }
      /*  for(int i =0;i<widget.savedCategories.length;i++){
            if(this.categoryList.length >0){
              for(int j =0;j<this.categoryList.length;j++){
                  if(this.categoryList[j].id == widget.savedCategories[i].id){
                    this.categoryList[j].isExpanded = false;
                    break;
                  }
                 }
              }
            } */
    }
    this.categoryList.sort((a, b) => a.name.length.compareTo(b.name.length));
    setState(() {
      print("all cats");
      print(jsonEncode(this.categoryList));
      print("saved cats");
      print(jsonEncode(widget.savedCategories));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Categories'),
          backgroundColor: Constants.toolbarColor,
        ),
        body: this.categoryList.length > 0
            ? Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/1.5,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: List<Widget>.generate(this.categoryList.length,
                            (int index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: FilterChip(
                              label: Text('${this.categoryList[index].name}'),
                              labelStyle: TextStyle(
                                  color: this.categoryList[index].isExpanded
                                      ? Colors.black
                                      : Colors.white),
                              selected: !this.categoryList[index].isExpanded,
                              onSelected: (bool selected) {
                                setState(() {
                                  print(selected);
                                  if(selected){
                                    widget.savedCategories.add(this.categoryList[index]);
                                  }else{
                                    for (int i=0;i < widget.savedCategories.length;i++) {
                                      if(widget.savedCategories[i].id == this.categoryList[index].id){
                                      widget.savedCategories.removeAt(i);
                                      }
                                    }
                                  }
                                  this.categoryList[index].isExpanded = !this.categoryList[index].isExpanded;
                                });
                              },
                              selectedColor: Colors.green,
                              checkmarkColor: Colors.white,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(20),
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            print("Categories  saved....!");
                            saveCategories();
                          }),
                    ),
                      ],
                    )
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
