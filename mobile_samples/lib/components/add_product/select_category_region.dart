import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:tradeleaves/components/add_product/postProduct.dart';
import 'package:tradeleaves/components/categories/manage_categories.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

class SelectCategoryRegion extends StatefulWidget {
  final ProductDTO productDTO;
  final bool isEdit;
  SelectCategoryRegion({this.isEdit, this.productDTO});
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
  ProductDTO product;

  getCompanyRegions() async {
    regions = await crmService.companyRegions();
    if(regions["partyCountryRegionListDTO"]["partyCountryRegionDTO"] == null){
      regions = {"partyCountryRegionListDTO":{"partyCountryRegionDTO":[{"partyCountryRegionId":"1bca163e-788b-4561-b8da-a173f8f21a8c","countryId":"US","countryName":"US","regionId":"ASIA"},{"partyCountryRegionId":"28f7fb13-bebe-4809-8def-cad0d8dbbb5d","countryId":"IN","countryName":"IN","regionId":"ASIA"},{"partyCountryRegionId":"479782c2-895b-4f30-83ce-e03475de8c1a","countryId":"SG","countryName":"SG","regionId":"ASIA"},{"partyCountryRegionId":"7263a058-1c1f-4369-a307-57011dd8718e","countryId":"AU","countryName":"AU","regionId":"ASIA"}],"partyId":"bf22e74d-e21f-4549-a3ef-a52e22350ffc"},"protocolVersion":1};
    }
                                  
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
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.lobId = this.user.allowedlob;
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
    setProductAttributeDetailDto(this
        .listCatProdAttrLoBRespDTO
        .listCatProdAttrLoBRespDTO
        .createCategoryProductAttributeDTO);
    for (var item in this
        .listCatProdAttrLoBRespDTO
        .listCatProdAttrLoBRespDTO
        .catProdAttrLoBListDTO) {
      setProductAttributeDetailDto(item.createCategoryProductAttributeDTO);
    }
  }

  setProductAttributeDetailDto(
      List<CreateCategoryProductAttributeDTO>
          createCategoryProductAttributeDTO) async {
    for (var createCategoryProductAttributeDTO
        in createCategoryProductAttributeDTO) {
      ProductAttributeDetailDTO productAttributeDetailDTO =
          ProductAttributeDetailDTO();
      productAttributeDetailDTO.value = null;
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
            productAttributeDetailDTO.price.priceList[0].productPriceSlabs
                .add(new ProductPriceSlabs());
          }
          break;
        default:
          {
            print("Invalid choice");
            productAttributeDetailDTO.valueType = "VARCHAR";
          }
          break;
      }
      createCategoryProductAttributeDTO.productAttributeDetailDTO =
          productAttributeDetailDTO;
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
                    regions: companyRegions
                        .partyCountryRegionListDTO.partyCountryRegionDTO,
                    user: user,
                  )),
        );
      });
    }
  }

  Future getProductDetails() async {
    print("get Product called...!");
    var pr = await catalogService.getProductById(widget.productDTO.productId);
    this.product = ProductDTO.fromJson(pr);
    print("product details is...!");
    print(jsonEncode(product));
  }

  @override
  void initState() {
    if (widget.productDTO != null && widget.isEdit) {
      getProductDetails();
    }
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              'Subscribed Categories',
                              style: TextStyle(fontSize: 16),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageCategories(
                                        user: this.user,
                                        savedCategories: this.savedCats,
                                      )),
                                );
                              }),
                        )
                      ],
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
                          (this.savedCats != null &&
                                  this.savedCats.length != 0 &&
                                  leafCats != null)
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
                                            onTap: () {
                                              setState(() {
                                                this
                                                        .savedCats[index1]
                                                        .isExpanded =
                                                    !this
                                                        .savedCats[index1]
                                                        .isExpanded;
                                              });
                                            },
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new IconButton(
                                                    icon: new Container(
                                                      child: new Icon(
                                                        this
                                                                .savedCats[
                                                                    index1]
                                                                .isExpanded
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
                                                        this
                                                                .savedCats[index1]
                                                                .isExpanded =
                                                            !this
                                                                .savedCats[
                                                                    index1]
                                                                .isExpanded;
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
                                                    0 &&
                                                this
                                                    .savedCats[index1]
                                                    .isExpanded)
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
                                                                        left:
                                                                            BorderSide(
                                                                          width:
                                                                              5,
                                                                          color: this.selectedCategory != null && this.selectedCategory == this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].categoryId
                                                                              ? Colors.green[700]
                                                                              : Colors.white,
                                                                        ),
                                                                        bottom: BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    height: 32,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            this.selectedCategory =
                                                                                this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].categoryId;
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          color: this.selectedCategory != null && this.selectedCategory == this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].categoryId
                                                                              ? Colors.grey[300]
                                                                              : Colors.white,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                width: 60,
                                                                              ),
                                                                              Text(
                                                                                '${this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].name}',
                                                                                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
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
                    regions != null
                        ? Container(
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
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        disabledColor: Colors.cyanAccent,
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
