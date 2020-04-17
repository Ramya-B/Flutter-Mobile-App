import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/main.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/productAttributesResp.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/cities.dart';
import 'package:tradeleaves/tl-services/core-npm/citiesImpl.dart';
import 'package:tradeleaves/tl-services/customs/customServiceImpl.dart';
import '../../service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddProduct extends StatefulWidget {
  final ProductAttributesResp productAttributes;
  final ListCatProdAttrLoBDTO categoryRegionLob;
  final List selectedCountries;
  final List<PartyCountryRegionDTO> regions;
  final User user;

  AddProduct(
      {this.productAttributes,
      this.categoryRegionLob,
      this.selectedCountries,
      this.regions,
      this.user});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<CreateCategoryProductAttributeDTO> prodValues = [];
  List<ProductAttributeDetailDTO> productAttributeDetailDTOList = [];
  List<ProductLobCountryStatusDTO> productLobCountryStatusDTOList;
  final formKey = new GlobalKey<FormState>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  CitiesServiceImpl get cityService => locator<CitiesServiceImpl>();
  CustomServiceImpl get customService => locator<CustomServiceImpl>();
  ProductDTO productDTO = new ProductDTO();
  ProductOptionDTO productOptionDTO = ProductOptionDTO();
  File file;
  String image;
  List<ImageDTO> imageList;
  List<TextEditingController> textFieldControllers;
  List<int> choosenCities;
  List<CityDetails> citiesList;
  List<UomDTO> uomsList;
  List<IncotermDto> incotermsList;
  List<Country> countryCodesList;
  List<PriceList> prices;
  PriceList price = new PriceList();
  List<ProductPriceSlabs> productPriceSlabs;
  String start;
  String end;
  String cost;

  @override
  void initState() {
    productPriceSlabs= [];
    prices = [];
    countryCodesList = [];
    choosenCities = [];
    citiesList = [];
    this.imageList = [];
    uomsList = [];
    incotermsList = [];
    getUomList();
    getCountryCodes();
    // getIncotermsList();
    getCities();
    super.initState();
  }

  _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      // form.save();
      await saveProduct();
      print("save product before service");
      print(jsonEncode(productDTO));
      await catalogService.saveProduct(productDTO);
      setState(() {
        print("set state of save form");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  setProductAttribute(
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO,
      var value) async {
    print("set product attributes called");
    print(value);
    ProductAttributeDetailDTO productAttributeDetailDTO =
        ProductAttributeDetailDTO();
    productAttributeDetailDTO.attributeName =
        createCategoryProductAttributeDTO.productAttributeDTO.name;
    productAttributeDetailDTO.required =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.required;
    productAttributeDetailDTO.displayType =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.displayType;
    productAttributeDetailDTO.categoryProductAttributeId =
        createCategoryProductAttributeDTO
            .catgryProductAttributeDTO.categoryProductAttributeId;
    productAttributeDetailDTO.productAttributeId =
        createCategoryProductAttributeDTO
            .catgryProductAttributeDTO.productAttributeId;
    productAttributeDetailDTO.facet =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.facet;
    productAttributeDetailDTO.searchable =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.searchable;
    productAttributeDetailDTO.variant =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.variant;
    productAttributeDetailDTO.sortable =
        createCategoryProductAttributeDTO.catgryProductAttributeDTO.sortable;
    productAttributeDetailDTO.value = value;
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
      default:
        {
          print("Invalid choice");
          productAttributeDetailDTO.valueType = "VARCHAR";
        }
        break;
    }
    /* print("before removing ");
    print(this.productAttributeDetailDTOList);
    for (var item in this.productAttributeDetailDTOList) {
      if (item.attributeName ==
          createCategoryProductAttributeDTO.productAttributeDTO.name) {
        print("removing the ${item.attributeName}");
        this.productAttributeDetailDTOList.remove(item);
      }
    } */
    this.productAttributeDetailDTOList.add(productAttributeDetailDTO);
    print(
        "${productAttributeDetailDTO.attributeName} -- ${productAttributeDetailDTO.value}into prod attributes..!");
    print(this.productAttributeDetailDTOList);
  }

  _getImageList(
      CreateCategoryProductAttributeDTO
          createCategoryProductAttributeDTO) async {
    var resultList = await MultiImagePicker.pickImages(
      maxImages: 5 - this.imageList.length,
      enableCamera: true,
    );
    print("printing product image file resulu set");

    // The data selected here comes back in the list
//    print(jsonEncode(resultList));

    for (var imageFile in resultList) {
      postImage(imageFile, resultList.length).then((imageResp) {
        // Get the download URL
        setState(() {
          print("postImage resp");
          print(imageResp);
          var imageInfo = json.decode(imageResp)["fileName"];

          ImageDTO imageDTO = ImageDTO();
          imageDTO.imageUrl = imageInfo;
          imageDTO.name = imageInfo;
          imageDTO.isCoverPhoto = false;
          imageDTO.isHide = true;
          imageDTO.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
          imageDTO.imageType = imageInfo
              .substring(imageInfo.lastIndexOf('.'), imageInfo.length)
              .toUpperCase();
          this.imageList.add(imageDTO);
          print("image List length is ${this.imageList.length}");
          print(this.imageList);
          if (this.imageList.length == 1) {
            setProductAttribute(
                createCategoryProductAttributeDTO, this.imageList[0].imageUrl);
          }
        });
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<dynamic> postImage(Asset imageFile, int length) async {
    print("printing product image file");
    print(imageFile.name);
    var path = await FlutterAbsolutePath.getAbsolutePath(imageFile.identifier);
    print(path);
    print(path);
    if (length == 1) {
      File path2 = await cropImage(path.toString());
      print("path2");
      print(path2?.path);
      print(path);
      path = path2 != null ? path2.path : path;
    }

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${Constants.envUrl}/mongoupload/attachments/?Override=false"));
    print("request");
    print(request);
    request.files.add(await http.MultipartFile.fromPath(
      'attachments',
      path,
      contentType: mime.MediaType('image', 'jpeg'),
    ));

    print("request is...!");
    print(request);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    print("image upload ...");
    print(respStr);
    return respStr;
  }

  Future cropImage(var path) async {
    print("image crop called...!");
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    print("before returning");
    print(croppedFile);
    return croppedFile;
  }

  saveProduct() {
    print("save product");
    print(this.productAttributeDetailDTOList);
    for (var item in this.productAttributeDetailDTOList) {
      switch (item.attributeName) {
        case "Product Name":
          {
            productDTO.productName = item.value;
          }
          break;
        case "Product Image":
          {
            productDTO.primaryImageUrl = this.imageList[0].imageUrl;
          }
          break;
        default:
          {
            print("Invalid choice");
          }
          break;
      }
    }
    print("step2");

    productDTO.type = "product";
    productDTO.channel = "B2BInternational"; //need to change
    productDTO.region = "IN"; //need to change
    productDTO.hsCodes = [];
    productDTO.status = "Created";
    productDTO.categoryIds = [widget.categoryRegionLob.categoryId];
    productDTO.selectedSites = [];
    productDTO.supplierId = widget.user.companyId;
    print(widget.user.companyId);
    print("bf22e74d-e21f-4549-a3ef-a52e22350ffc");
    productDTO.productAttributeDetailDTO = productAttributeDetailDTOList;
    productDTO.productOptionDTO = [];
    productDTO.productLobCountryStatusDTO = [];
    print("step3");
    for (var item in widget.categoryRegionLob.lobId) {
      for (var countries in widget.selectedCountries) {
        ProductLobCountryStatusDTO productLobCountryStatusDTO =
            ProductLobCountryStatusDTO();
        productLobCountryStatusDTO.productLobCountryStatusId = null;
        productLobCountryStatusDTO.productId = null;
        productLobCountryStatusDTO.lobId = item.toString();
        for (var regions in widget.regions) {
          productLobCountryStatusDTO.regionId = regions.regionId;
        }
        productLobCountryStatusDTO.countryId = countries.toString();
        productLobCountryStatusDTO.statusId = "Created";
        productLobCountryStatusDTO.reason = null;
        productDTO.productLobCountryStatusDTO.add(productLobCountryStatusDTO);
      }
    }

    productOptionDTO.productOptionName = productDTO.productName;
    productOptionDTO.productAttributeDetailDTO = [];
    this.prices.add(this.price);
    productOptionDTO.priceList = this.prices;
    productOptionDTO.deliveryScheduleDTO = [];
    productOptionDTO.imageDTO = this.imageList;
    productOptionDTO.start = "2000-10-22"; //need to change
    productDTO.productOptionDTO.add(productOptionDTO);
  }

  getCities() async {
    print("get cities called...!");
    var cities =
        await cityService.getCitiesByCountryCodes(widget.selectedCountries);
    setState(() {
      citiesList = List<CityDetails>.from(
          cities.map((data) => CityDetails.fromJson(data)).toList());
      print("get cities resp...!");
      print(citiesList);
    });
  }

  setCityTypeProdAttribute(
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO,
      List<int> cityIndexes) async {
    if (cityIndexes.length > 0) {
      for (int i = 0; i < cityIndexes.length; i++) {
        print(this.citiesList[i].city);
        setProductAttribute(createCategoryProductAttributeDTO,
            this.citiesList[i].village.toString());
      }
    }
  }

  getUomList() async {
    var uoms = await customService.getUoms();
    print(uoms);
    uomsList =
        List<UomDTO>.from(uoms.map((data) => UomDTO.fromJson(data))).toList();
  }

  getIncotermsList() async {
    var incoterms = await customService.getIncoterms();
    print(incoterms);
    setState(() {
      incotermsList = List<IncotermDto>.from(
          incoterms.map((data) => IncotermDto.fromJson(data))).toList();
    });
  }

  getCountryCodes() async {
    var countryCodes = await customService.countryCodes();
    print("countryCodes");
    print(countryCodes);
    setState(() {
      setState(() {
          this.countryCodesList =
          List<Country>.from(countryCodes.map((data) => Country.fromJson(data)))
              .toList();
      });
    
    });
  }

  setPriceList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Add Product'), backgroundColor: Colors.green),
        body: ListView(
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                        padding: EdgeInsets.all(10),
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
                              (widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "text" ||
                                      widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "email" ||
                                      widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "number" ||
                                      widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "url")
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      // margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        keyboardType: widget
                                                    .productAttributes
                                                    .listCatProdAttrLoBRespDTO
                                                    .createCategoryProductAttributeDTO[
                                                        index]
                                                    .catgryProductAttributeDTO
                                                    .displayType ==
                                                "email"
                                            ? TextInputType.emailAddress
                                            : widget
                                                        .productAttributes
                                                        .listCatProdAttrLoBRespDTO
                                                        .createCategoryProductAttributeDTO[
                                                            index]
                                                        .catgryProductAttributeDTO
                                                        .displayType ==
                                                    "url"
                                                ? TextInputType.url
                                                : widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .catgryProductAttributeDTO
                                                            .displayType ==
                                                        "number"
                                                    ? TextInputType.number
                                                    : TextInputType.text,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            hintText: widget
                                                .productAttributes
                                                .listCatProdAttrLoBRespDTO
                                                .createCategoryProductAttributeDTO[
                                                    index]
                                                .productAttributeDTO
                                                .name
                                                .toString(),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        validator: (arg1) {
                                          print("validator called...$arg1");
                                          setProductAttribute(
                                              widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[
                                                  index],
                                              arg1);
                                          // if(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="email"){
                                          //   return !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(arg1)?"Enter Valid Email":null;
                                          // }else if(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="url"){
                                          //   return !RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)').hasMatch(arg1)?"Enter Valid Email":null;
                                          // }
                                          return null;
                                        },
                                        // onChanged: (String value) {
                                        //   print("On chaged called");
                                        //   print(value);
                                        //   setState(() {
                                        //     setProductAttribute(
                                        //         widget
                                        //             .productAttributes
                                        //             .listCatProdAttrLoBRespDTO
                                        //             .createCategoryProductAttributeDTO[index],
                                        //         value);
                                        //   });
                                        // }
                                        // onSaved: (String value){
                                        //  setState(() {
                                        //     print("onsave called...$value");
                                        //   setProductAttribute(
                                        //         widget
                                        //             .productAttributes
                                        //             .listCatProdAttrLoBRespDTO
                                        //             .createCategoryProductAttributeDTO[index],
                                        //         value);

                                        //  });
                                        // },
                                      ),
                                    )
                                  : widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "images"
                                      ? Container(
                                          height: imageList.length > 0 &&
                                                  imageList.length < 5
                                              ? 140
                                              : imageList.length == 5
                                                  ? 100
                                                  : 50,
                                          child: Column(
                                            children: <Widget>[
                                              imageList.length > 0
                                                  ? GridView.count(
                                                      shrinkWrap: true,
                                                      crossAxisCount: 5,
                                                      childAspectRatio: 1,
                                                      children: List.generate(
                                                          imageList.length,
                                                          (index) {
                                                        if (imageList.length >
                                                            0) {
                                                          ImageDTO uploadModel =
                                                              imageList[index];
                                                          return Container(
                                                            width: 50,
                                                            height: 50,
                                                            child: Card(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Image.network(
                                                                    '${Constants.envUrl}${Constants.mongoImageUrl}/${uploadModel.imageUrl}',
                                                                    width: 300,
                                                                    height: 300,
                                                                  ),
                                                                  Positioned(
                                                                    right: 0,
                                                                    top: 0,
                                                                    child:
                                                                        InkWell(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove_circle,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          imageList
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Container(
                                                            width: 50,
                                                            height: 50,
                                                            child: Card(
                                                              child: IconButton(
                                                                icon: Icon(
                                                                    Icons.add),
                                                                onPressed: () {
                                                                  _getImageList(widget
                                                                      .productAttributes
                                                                      .listCatProdAttrLoBRespDTO
                                                                      .createCategoryProductAttributeDTO[index]);
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                    )
                                                  : Container(),
                                              imageList.length < 5
                                                  ? IconButton(
                                                      onPressed: () {
                                                        _getImageList(widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[index]);
                                                        // _choose(widget
                                                        //     .productAttributes
                                                        //     .listCatProdAttrLoBRespDTO
                                                        //     .createCategoryProductAttributeDTO[index]);
                                                      },
                                                      icon: Icon(
                                                          Icons.library_add))
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      : widget
                                                  .productAttributes
                                                  .listCatProdAttrLoBRespDTO
                                                  .createCategoryProductAttributeDTO[
                                                      index]
                                                  .catgryProductAttributeDTO
                                                  .displayType ==
                                              "date"
                                          ? Container(
                                              height: 100,
                                              padding: EdgeInsets.all(10.0),
                                              child: DateTimeField(
                                                decoration: InputDecoration(
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                  ),
                                                  hintText: widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[
                                                          index]
                                                      .productAttributeDTO
                                                      .name
                                                      .toString(),
                                                  // border: OutlineInputBorder(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             8))
                                                ),
                                                onChanged: (DateTime val){
                                                  print(val.toUtc());

                                                },
                                                validator: (val){
                                                  print("date is");
                                                  print(val.toUtc());
                                                  setProductAttribute(
                                                    widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[index],  val.toUtc().toString());
                                                  
                                            
                                                  return null;
                                                },
                                                format:
                                                    DateFormat("yyyy-MM-dd"),
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate: currentValue
                                                               ??
                                                          DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                },
                                              ))
                                          : widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[
                                                          index]
                                                      .catgryProductAttributeDTO
                                                      .displayType ==
                                                  "City Type"
                                              ? Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: SearchableDropdown
                                                      .multiple(
                                                    items: citiesList.map(
                                                        (CityDetails
                                                            cityDetail) {
                                                      return DropdownMenuItem<
                                                          CityDetails>(
                                                        value: cityDetail,
                                                        child: Text(
                                                            cityDetail.village),
                                                      );
                                                    }).toList(),
                                                    selectedItems:
                                                        choosenCities,
                                                    hint: "Select Cities",
                                                    searchHint: "Select Cities",
                                                    displayClearIcon: false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        print(
                                                            "city on changed");
                                                        print(value);
                                                        choosenCities = value;
                                                        setCityTypeProdAttribute(
                                                            widget
                                                                .productAttributes
                                                                .listCatProdAttrLoBRespDTO
                                                                .createCategoryProductAttributeDTO[index],
                                                            choosenCities);
                                                      });
                                                    },
                                                    dialogBox: true,
                                                    closeButton:
                                                        (choosenCities) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          RaisedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  choosenCities
                                                                      .clear();
                                                                  choosenCities.addAll(Iterable<
                                                                              int>.generate(
                                                                          citiesList
                                                                              .length)
                                                                      .toList());
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Select all")),
                                                          RaisedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  choosenCities
                                                                      .clear();
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Deselect all")),
                                                        ],
                                                      );
                                                    },
                                                    isExpanded: true,
                                                  ),
                                                )
                                              : widget
                                                          .productAttributes
                                                          .listCatProdAttrLoBRespDTO
                                                          .createCategoryProductAttributeDTO[
                                                              index]
                                                          .catgryProductAttributeDTO
                                                          .displayType ==
                                                      "price"
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: <Widget>[
                                                          Text(
                                                              'Unit of Measurement'),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          DropdownButton(
                                                            hint: Text(
                                                                'select UOM'),
                                                            isExpanded: true,
                                                            iconSize: 30.0,
                                                            items: this
                                                                .uomsList
                                                                .map(
                                                              (val) {
                                                                return DropdownMenuItem<
                                                                    UomDTO>(
                                                                  value: val,
                                                                  child: Text(
                                                                      val.unit),
                                                                );
                                                              },
                                                            ).toList(),
                                                            onChanged: (val) {
                                                              setState(
                                                                () {
                                                                  // this.industryType = val;
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ])
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      // margin: EdgeInsets.all(10),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        20,
                                                                        15,
                                                                        20,
                                                                        15),
                                                            hintText: widget
                                                                .productAttributes
                                                                .listCatProdAttrLoBRespDTO
                                                                .createCategoryProductAttributeDTO[
                                                                    index]
                                                                .productAttributeDTO
                                                                .name
                                                                .toString(),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8))),
                                                        validator: (arg1) {
                                                          return null;
                                                        },
                                                      ))
                            ],
                          );
                        }),
                    ListView.builder(
                        padding: EdgeInsets.all(10),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget
                            .productAttributes
                            .listCatProdAttrLoBRespDTO
                            .catProdAttrLoBListDTO
                            .length,
                        itemBuilder: (BuildContext context, int index1) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget
                                  .productAttributes
                                  .listCatProdAttrLoBRespDTO
                                  .catProdAttrLoBListDTO[index1]
                                  .createCategoryProductAttributeDTO
                                  .length,
                              itemBuilder: (context, int index2) {
                                return Column(
                                  children: <Widget>[
                                    widget
                                                .productAttributes
                                                .listCatProdAttrLoBRespDTO
                                                .catProdAttrLoBListDTO[index1]
                                                .createCategoryProductAttributeDTO[
                                                    index2]
                                                .catgryProductAttributeDTO
                                                .displayType ==
                                            "price"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                                Container(
                                                  child: Text(
                                                      'Unit of Measurement'),
                                                  padding: EdgeInsets.all(10),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: DropdownButton(
                                                    hint: Text('select UOM'),
                                                    isExpanded: true,
                                                    // value: price.unitType,
                                                    iconSize: 30.0,
                                                    items: this.uomsList.map(
                                                      (val) {
                                                        return DropdownMenuItem<
                                                            UomDTO>(
                                                          value: val,
                                                          child: Text(val.unit),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) {
                                                      setState(
                                                        () {
                                                          print(val);
                                                           this.price.unitType =
                                                               val.unit.toString();
                                                               print(this.price.unitType);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text('Currency')),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: DropdownButton(
                                                    hint: Text(
                                                        'select Price Type'),
                                                    // value: price.currency,
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    items: this
                                                        .countryCodesList
                                                        .map(
                                                      (val) {
                                                        return DropdownMenuItem<
                                                            Country>(
                                                          value: val,
                                                          child: Text(
                                                              val.currency),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (val) {
                                                      setState(
                                                        () {
                                                          this.price.currency =
                                                              val.currency;
                                                              print(this.price.currency);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                        'Per Unit Weight In Kg \'s ')),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 5, 5, 10),
                                                        hintText: 'Per Unit Weight In Kg \'s ',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                    validator: (arg1) {
                                                      setProductAttribute(
                                                          widget
                                                              .productAttributes
                                                              .listCatProdAttrLoBRespDTO
                                                              .catProdAttrLoBListDTO[
                                                                  index1]
                                                              .createCategoryProductAttributeDTO[index2],
                                                          arg1);
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                      'Minimum Order Quantity'),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 5, 5, 10),
                                                        hintText: 'Minimum Order Quantity',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                     validator: (arg1) {
                                                      setProductAttribute(
                                                          widget
                                                              .productAttributes
                                                              .listCatProdAttrLoBRespDTO
                                                              .catProdAttrLoBListDTO[
                                                                  index1]
                                                              .createCategoryProductAttributeDTO[index2],
                                                          '$arg1 ${this.price.unitType}');
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text('Quantity Range'),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: TextFormField(
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          5,
                                                                          10),
                                                              hintText: 'Start',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                          validator: (arg1) {
                                                            return null;
                                                          },
                                                          onChanged: (String val){
                                                            this.start =val;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Text('-'),
                                                    Expanded(
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: TextFormField(
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          5,
                                                                          10),
                                                              hintText: 'End',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                          validator: (arg1) {
                                                            return null;
                                                          },
                                                          onChanged: (String val){
                                                            this.end =val;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Text('%'),
                                                    Expanded(
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: TextFormField(
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          5,
                                                                          10),
                                                              hintText: 'Price',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                          validator: (arg1) {
                                                            return null;
                                                          },
                                                          onChanged: (String val){
                                                            this.cost =val;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          Text('/Centimeter'),
                                                    ),
                                                    Container(
                                                      child: ClipOval(
                                                        child: Material(
                                                          color: Colors
                                                              .green, // button color
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .lightGreen, // inkwell color
                                                            child: SizedBox(
                                                                width: 35,
                                                                height: 35,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            onTap: () {
                                                              ProductPriceSlabs productPriceSlabs = new ProductPriceSlabs();
                                                              productPriceSlabs.rangeStart  = this.end;
                                                              productPriceSlabs.price = this.cost;
                                                              this.productPriceSlabs.add(productPriceSlabs);
                                                              this.price.productPriceSlabs = this.productPriceSlabs;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ])
                                        : Container()
                                  ],
                                );
                              });
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
