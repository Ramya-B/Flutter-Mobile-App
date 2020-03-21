import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/user.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

class AddProduct extends StatefulWidget {
  final ProductAttributesResp productAttributes;
  final ListCatProdAttrLoBDTO categoryRegionLob;
  final List<String> regions;

  AddProduct({this.productAttributes, this.categoryRegionLob, this.regions});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<CreateCategoryProductAttributeDTO> prodValues = [];
  List<ProductAttributeDetailDTO> productAttributeDetailDTOList;
  List<ProductLobCountryStatusDTO> productLobCountryStatusDTOList;
   final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
   _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      await saveProduct();

      setState(() {
      
      });
    }
  }

  saveProduct() {
    ProductDTO productDTO = new ProductDTO();
    for (var item in productAttributeDetailDTOList) {
      switch (item.attributeName) {
        case "Product Name":
          {
            productDTO.productName = item.value;
          }
          break;
        default:
          {
            print("Invalid choice");
          }
          break;
      }
      // item.attributeName == ;

    }

    productDTO.primaryImageUrl =
        "76f912dc-2271-437e-afce-7329f798658f/joker.jpg";
    productDTO.type = "product";
    productDTO.channel = "B2BInternational";
    productDTO.region = "IN";
    productDTO.hsCodes = [];
    productDTO.status = "Created";
    productDTO.categoryIds = [widget.categoryRegionLob.categoryId];
    productDTO.selectedSites = [];
    productDTO.supplierId = "bf22e74d-e21f-4549-a3ef-a52e22350ffc";
    productDTO.productAttributeDetailDTO = productAttributeDetailDTOList;
    productDTO.productOptionDTO = [];
    productDTO.productLobCountryStatusDTO = [];
    for (var item in widget.categoryRegionLob.lobId) {
      for (var countries in widget.regions) {
        ProductLobCountryStatusDTO productLobCountryStatusDTO = ProductLobCountryStatusDTO();
        productLobCountryStatusDTO.productLobCountryStatusId = null;
				productLobCountryStatusDTO.productId = null;
				productLobCountryStatusDTO.lobId = item.toString();
				productLobCountryStatusDTO.regionId ="ASIA";
				productLobCountryStatusDTO.countryId = countries.toString();
				productLobCountryStatusDTO.statusId = "Created";
				productLobCountryStatusDTO.reason = null;
        productDTO.productLobCountryStatusDTO.add(productLobCountryStatusDTO);
      }
    }
    ProductOptionDTO productOptionDTO = ProductOptionDTO();
    productOptionDTO.productOptionName =  productDTO.productName ;
    productOptionDTO.productAttributeDetailDTO= [];
    productOptionDTO.priceList= [];
    productOptionDTO.deliveryScheduleDTO= [];
    productOptionDTO.imageDTO = [];
    ImageDTO imageDTO= ImageDTO();
    imageDTO.imageUrl = "76f912dc-2271-437e-afce-7329f798658f/joker.jpg";
    imageDTO.name = "76f912dc-2271-437e-afce-7329f798658f/joker.jpg";
    imageDTO.isCoverPhoto = true;
    imageDTO.isHide = true;
    imageDTO.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
    imageDTO.imageType = "JPG";
    productOptionDTO.imageDTO.add(imageDTO);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Add Product'), backgroundColor: Colors.green),
        body: ListView(
          children: <Widget>[
            Form(
                child: Column(
              children: <Widget>[
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget
                        .productAttributes
                        .listCatProdAttrLoBRespDTO
                        .createCategoryProductAttributeDTO
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(widget
                                .productAttributes
                                .listCatProdAttrLoBRespDTO
                                .createCategoryProductAttributeDTO[index]
                                .productAttributeDTO
                                .name),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .productAttributeDTO
                                      .name
                                      .toString(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              validator: (arg1) {
                                return null;
                              },
                              onSaved: (String value) {
                                setState(() {
                                  ProductAttributeDetailDTO
                                      productAttributeDetailDTO =
                                      ProductAttributeDetailDTO();
                                  productAttributeDetailDTO.attributeName =
                                      widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .productAttributeDTO
                                          .name;
                                  productAttributeDetailDTO.valueType =
                                      "VARCHAR";
                                  productAttributeDetailDTO.required = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .required;
                                  productAttributeDetailDTO.displayType = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .displayType;
                                  productAttributeDetailDTO
                                          .categoryProductAttributeId =
                                      widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .catgryProductAttributeDTO
                                          .categoryProductAttributeId;
                                  productAttributeDetailDTO.productAttributeId =
                                      widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .catgryProductAttributeDTO
                                          .productAttributeId;
                                  productAttributeDetailDTO.facet = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .facet;
                                  productAttributeDetailDTO.searchable = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .searchable;
                                  productAttributeDetailDTO.variant = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .variant;
                                  productAttributeDetailDTO.sortable = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .sortable;
                                  productAttributeDetailDTO.value = value;
                                  productAttributeDetailDTO.lobId = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .lobId;
                                  productAttributeDetailDTO.prodAttrId = widget
                                      .productAttributes
                                      .listCatProdAttrLoBRespDTO
                                      .createCategoryProductAttributeDTO[index]
                                      .catgryProductAttributeDTO
                                      .productAttributeId;
                                  for (var item
                                      in productAttributeDetailDTOList) {
                                    if (item.attributeName ==
                                        widget
                                            .productAttributes
                                            .listCatProdAttrLoBRespDTO
                                            .createCategoryProductAttributeDTO[
                                                index]
                                            .productAttributeDTO
                                            .name) {
                                      productAttributeDetailDTOList
                                          .remove(item);
                                    }
                                  }
                                  productAttributeDetailDTOList
                                      .add(productAttributeDetailDTO);
                                  print(productAttributeDetailDTOList);
                                });
                              },
                              onChanged: (String value) {
                                setState(() {
                                  print(
                                      "${widget.productAttributes.listCatProdAttrLoBRespDTO}");
                                  print("$value");
                                  prodValues.add(widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                      index]);
                                  print("$prodValues");
                                });
                              },
                            ),
                          )
                        ],
                      );
                    }),
                Container(
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Save Product',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _saveForm();
                        print("product saved....!");
                      }),
                ),
              ],
            ))
          ],
        ));
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
  List selectedLobs;
  bool isChecked = false;
  CompanyRegionsResp companyRegions;
  var regions;
  List selectedRegions;
  final formKey = new GlobalKey<FormState>();
  ProductAttributesResp listCatProdAttrLoBRespDTO;
  ListCatProdAttrLoBDTO listCatProdAttrLoBDTO = new ListCatProdAttrLoBDTO();

  List lobs = [
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0641",
      "lobName": "MarketPlace - Global"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0642",
      "lobName": "BLISS - Domestic"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0643",
      "lobName": "BLISS - Global"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0644",
      "lobName": "MarketPlace - Domestic"
    }
  ];
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
  }

  _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      await getProductAttributes();

      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProduct(
                    productAttributes: this.listCatProdAttrLoBRespDTO,
                    categoryRegionLob: listCatProdAttrLoBDTO,
                    regions: selectedRegions)));
      });
    }
  }

  @override
  void initState() {
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
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Form(
                key: formKey,
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
                          (this.response == true)
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
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new IconButton(
                                                    icon: new Container(
                                                      child: new Icon(
                                                        expandFlag
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
                                                        expandFlag =
                                                            !expandFlag;
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
                                                                      highlightColor: (this.selectedCategory == this.leafCats.categoryTreePathDto.childCategoryDto[index2].leafCategoryListDto[index3].categoryId)
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                      child:
                                                                          Row(
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
                    Container(
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
                    ),
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
