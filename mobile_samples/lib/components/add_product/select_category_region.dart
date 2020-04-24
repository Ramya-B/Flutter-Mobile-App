import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:tradeleaves/components/add_product/postProduct.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

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
  List selectedLobs;
  bool isChecked = false;
  CompanyRegionsResp companyRegions;
  var regions;
  List selectedRegions;
  final _formKey = new GlobalKey<FormState>();
  ProductAttributesResp listCatProdAttrLoBRespDTO;
  ListCatProdAttrLoBDTO listCatProdAttrLoBDTO = new ListCatProdAttrLoBDTO();
  List lobs = Constants.lobs;
  getCompanyRegions() async {
    regions = await crmService.companyRegions();
    companyRegions = CompanyRegionsResp.fromJson(regions);
    print("company regions...");
    print(companyRegions);
    print(companyRegions.partyCountryRegionListDTO);

    print(regions);
    setState(() {
      companyRegions = CompanyRegionsResp.fromJson(regions);
    });
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
    listCatProdAttrLoBDTO.categoryId = this.selectedCategory;
    listCatProdAttrLoBDTO.lobId = this.selectedLobs;
    var prodAttr =
        await catalogService.getProductAttributesByLob(listCatProdAttrLoBDTO);
    print("getProductAttributes");
    print(prodAttr);
    this.listCatProdAttrLoBRespDTO = ProductAttributesResp.fromJson(prodAttr);
    setProductAttributeDetailDto(this.listCatProdAttrLoBRespDTO.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO);
    for (var item in this.listCatProdAttrLoBRespDTO.listCatProdAttrLoBRespDTO.catProdAttrLoBListDTO) {
      setProductAttributeDetailDto(item.createCategoryProductAttributeDTO);
    }
  }

  setProductAttributeDetailDto(List<CreateCategoryProductAttributeDTO> createCategoryProductAttributeDTO) async{
 for (var createCategoryProductAttributeDTO in createCategoryProductAttributeDTO ) {
     ProductAttributeDetailDTO productAttributeDetailDTO =
          ProductAttributeDetailDTO();
      productAttributeDetailDTO.attributeName =
          createCategoryProductAttributeDTO.productAttributeDTO.name;
      productAttributeDetailDTO.required =
          createCategoryProductAttributeDTO.catgryProductAttributeDTO.required;
      productAttributeDetailDTO.displayType = createCategoryProductAttributeDTO
          .catgryProductAttributeDTO.displayType;
      productAttributeDetailDTO.categoryProductAttributeId =
          createCategoryProductAttributeDTO
              .catgryProductAttributeDTO.categoryProductAttributeId;
      productAttributeDetailDTO.productAttributeId =
          createCategoryProductAttributeDTO
              .catgryProductAttributeDTO.productAttributeId;
      productAttributeDetailDTO.facet =
          createCategoryProductAttributeDTO.catgryProductAttributeDTO.facet;
      productAttributeDetailDTO.searchable = createCategoryProductAttributeDTO
          .catgryProductAttributeDTO.searchable;
      productAttributeDetailDTO.variant =
          createCategoryProductAttributeDTO.catgryProductAttributeDTO.variant;
      productAttributeDetailDTO.sortable =
          createCategoryProductAttributeDTO.catgryProductAttributeDTO.sortable;
      productAttributeDetailDTO.value = null;
      productAttributeDetailDTO.valuesList = null;
      productAttributeDetailDTO.lobId =
          createCategoryProductAttributeDTO.catgryProductAttributeDTO.lobId;
      productAttributeDetailDTO.prodAttrId = createCategoryProductAttributeDTO
          .catgryProductAttributeDTO.productAttributeId;

      switch (createCategoryProductAttributeDTO
          .catgryProductAttributeDTO.displayType) {
        case "textarea":
          {
            productAttributeDetailDTO.valueType = "BLOB";
          }
          break;
        case "price":
          {
            productAttributeDetailDTO.price = new Price();
            productAttributeDetailDTO.price.priceList = [];
            productAttributeDetailDTO.price.priceList.add(new PriceList());
            productAttributeDetailDTO.price.priceList[0].productPriceSlabs = [];
            productAttributeDetailDTO.price.priceList[0].productPriceSlabs.add(new ProductPriceSlabs());
            
          }
          break;
        default:
          {
            print("Invalid choice");
            productAttributeDetailDTO.valueType = "VARCHAR";
          }
          break;
      }
      createCategoryProductAttributeDTO.productAttributeDetailDTO = productAttributeDetailDTO;
    }
  }
  _saveForm() async {
    print(_formKey);
    var form = _formKey.currentState;
    if (form.validate()) {
      await getProductAttributes();
      print("after get prodattributes");
      setState(() {
        print("set state of save form");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProduct1(
                    productAttributes: this.listCatProdAttrLoBRespDTO,
                    categoryRegionLob: listCatProdAttrLoBDTO,
                    selectedCountries: selectedRegions,
                    regions:companyRegions.partyCountryRegionListDTO.partyCountryRegionDTO,
                    user: user,)),
                    );
      });
    }
  }

  @override
  void initState() {
    savedCats = [];
    selectedLobs = [];
    selectedRegions = [];
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
          backgroundColor: Constants.toolbarColor,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
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
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          (this.savedCats != null && this.savedCats.length != 0 && leafCats != null)
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: this.savedCats.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                this.savedCats[index1].isExpanded = !this.savedCats[index1].isExpanded;
                                              });
                                            },
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new IconButton(
                                                    icon: new Container(
                                                      child: new Icon(
                                                        this.savedCats[index1].isExpanded
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        color: Colors.black,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        this.savedCats[index1].isExpanded = !this.savedCats[index1].isExpanded;
                                                      });
                                                    }),
                                                Text(
                                                  '${this.savedCats[index1].name}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                0  &&  this.savedCats[index1].isExpanded)
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
                                                itemBuilder:
                                                    (context, int index2) {
                                                  return (this
                                                              .savedCats[index1]
                                                              .id ==
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
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: this
                                                                    .leafCats
                                                                    .categoryTreePathDto
                                                                    .childCategoryDto[
                                                                        index2]
                                                                    .leafCategoryListDto
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        int index3) {
                                                                  return Container(
                                                                    
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                            left: BorderSide(
                                                                              width: 5,
                                                                              color:this.selectedCategory !=null && this.selectedCategory ==this
                                                                              .leafCats
                                                                              .categoryTreePathDto
                                                                              .childCategoryDto[index2]
                                                                              .leafCategoryListDto[index3]
                                                                              .categoryId ? Colors.red:Colors.white,
                                                                            ) ,
                                                                        bottom: BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    height: 32,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          this.selectedCategory = this
                                                                              .leafCats
                                                                              .categoryTreePathDto
                                                                              .childCategoryDto[index2]
                                                                              .leafCategoryListDto[index3]
                                                                              .categoryId;
                                                                        });
                                                                      },
                                                                      child:
                                                                         Container(
                                                                           color:  this.selectedCategory !=null && this.selectedCategory ==this
                                                                              .leafCats
                                                                              .categoryTreePathDto
                                                                              .childCategoryDto[index2]
                                                                              .leafCategoryListDto[index3]
                                                                              .categoryId ? Colors.grey[300]:Colors.white,
                                                                           child:  Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            width:
                                                                                60,
                                                                          ),
                                                                          Text(
                                                                            '${this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].name}',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                         )
                                                                    ),
                                                                  );
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: MultiSelectFormField(
                        autovalidate: false,
                        titleText: 'LOB',
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please select one or more options';
                          }
                          return null;
                        },
                        dataSource: lobs,
                        textField: 'lobName',
                        valueField: 'lobId',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        // required: true,
                        hintText: 'Please choose one or more',
                        value: selectedLobs,
                        onSaved: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedLobs = value;
                            print(selectedLobs);
                          });
                        },
                      ),
                    ),
                    regions != null ?Container(
                      padding: EdgeInsets.all(16),
                      child: MultiSelectFormField(
                        autovalidate: false,
                        titleText: 'Regions',
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please select one or more options';
                          }
                          return null;
                        },
                        dataSource: regions["partyCountryRegionListDTO"]
                            ["partyCountryRegionDTO"],
                        textField: 'countryName',
                        valueField: 'countryName',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        // required: true,
                        hintText: 'Please choose one or more',
                        value: selectedRegions,
                        onSaved: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedRegions = value;
                            print(selectedRegions);
                          });
                        },
                      ),
                    ):Container(),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _saveForm,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
