import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:tradeleaves/components/products/userproducts.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/productAttributesResp.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/citiesImpl.dart';
import 'package:tradeleaves/tl-services/customs/customServiceImpl.dart';
import '../../service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;
import 'package:intl/intl.dart';

class AddProduct1 extends StatefulWidget {
  final ProductAttributesResp productAttributes;
  final ListCatProdAttrLoBDTO categoryRegionLob;
  final List selectedCountries;
  final List<PartyCountryRegionDTO> regions;
  final User user;

  AddProduct1(
      {this.productAttributes,
      this.categoryRegionLob,
      this.selectedCountries,
      this.regions,
      this.user});
  @override
  _AddProduct1State createState() => _AddProduct1State();
}

class _AddProduct1State extends State<AddProduct1> {
  List<CreateCategoryProductAttributeDTO> prodValues = [];
  List<ProductAttributeDetailDTO> productAttributeDetailDTOList = [];
  List<ProductLobCountryStatusDTO> productLobCountryStatusDTOList;
  final formKey = new GlobalKey<FormState>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  CitiesServiceImpl get cityService => locator<CitiesServiceImpl>();
  CustomServiceImpl get customService => locator<CustomServiceImpl>();

  File file;
  String image;
  List<ImageDTO> imageList;
  List<TextEditingController> textFieldControllers;
  List<int> choosenCities;
  List<CityDetails> citiesList;
  List<UomDTO> uomsList;
  List<IncotermDto> incotermsList;
  List<Country> countryCodesList;
  List<PriceList> priceList;
  List<ProductOptionDTO> productOptionDTOList;
  List<DeliveryScheduleDTO> deliveryScheduleDTOList;
  List test = [];
  List<Faqs> faqs;
  List<ProductAttributeDetailDTO> customList;
  ProductDTO product;
  @override
  void initState() {
    faqs = [];
    customList = [];
    setCustomAttr();
    setFaqs();
    productOptionDTOList = [];
    this.deliveryScheduleDTOList = [];
    priceList = [];
    countryCodesList = [];
    choosenCities = [];
    citiesList = [];
    this.imageList = [];
    uomsList = [];
    incotermsList = [];
    getUomList();
    getCountryCodes();
    getIncotermsList();
    getCities();
    // handleEditProduct( this.product);
    super.initState();
  }

 

  handleEditProduct(ProductDTO product) async {
    print("handleEditProduct");
    print(jsonEncode(product.productAttributeDetailDTO));

    for (int i = 0;
        i <
            widget.productAttributes.listCatProdAttrLoBRespDTO
                .createCategoryProductAttributeDTO.length;
        i++) {
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO =
          widget.productAttributes.listCatProdAttrLoBRespDTO
              .createCategoryProductAttributeDTO[i];
      for (int j = 0; j < product.productAttributeDetailDTO.length; j++) {
        ProductAttributeDetailDTO prod = product.productAttributeDetailDTO[j];
        switch (createCategoryProductAttributeDTO
            .productAttributeDetailDTO.displayType) {
          case "name":
          case "email":
          case "number":
            {
              print("name setted...${prod.value}");
              widget
                  .productAttributes
                  .listCatProdAttrLoBRespDTO
                  .createCategoryProductAttributeDTO[i]
                  .productAttributeDetailDTO
                  .value = prod.value;
            }
            break;
        }
      }
    }
  }

  setFaqs() async {
    faqs.add(new Faqs());
  }

  getFilePickers(
      CreateCategoryProductAttributeDTO
          createCategoryProductAttributeDTO) async {
    // print("file pickers are called..!");
    // // List<File> files = await FilePicker.getMultiFile(
    // //   type: FileType.custom,
    // //   allowedExtensions: ['jpg', 'pdf', 'doc'],
    // // );
    // print(files);

    // for (var fileItem in files) {
    //   switch (fileItem.path.toString().substring(
    //       fileItem.path.toString().lastIndexOf('.'),
    //       fileItem.path.toString().length)) {
    //     case 'jpg':
    //     case 'jpeg':
    //     case 'JPG':
    //     case 'JPEG':
    //       mime.MediaType('image', 'jpeg');
    //       break;
    //   }
    //   print(fileItem.path);
    //   var request = http.MultipartRequest(
    //       'POST',
    //       Uri.parse(
    //           "${Constants.envUrl}/mongoupload/attachments/?Override=false"));
    //   request.files.add(await http.MultipartFile.fromPath(
    //     'attachments',
    //     fileItem.path,
    //     contentType: null,
    //   ));

    //   print("request is...!");
    //   print(request);
    //   var res = await request.send();
    //   final respStr = await res.stream.bytesToString();
    //   print("image upload ...");
    //   print(respStr);
    //   var imageInfo = json.decode(respStr)["fileName"];
    //   setProductAttribute(createCategoryProductAttributeDTO, imageInfo);
    // }
  }

  _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      // form.save();
      ProductDTO productDTO = saveProduct();
      print('hitting backend...');
      await catalogService.saveProduct(productDTO);
      setState(() {
        print("set state of save form");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserProducts()));
      });
    }
  }

  setProductAttribute(
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO,
      var value) async {
    if (value != null) {
      print("set product attributes called");
      print(value);
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
      this.productAttributeDetailDTOList.add(productAttributeDetailDTO);
      print(
          "${productAttributeDetailDTO.attributeName} -- ${productAttributeDetailDTO.value}into prod attributes..!");
      print(this.productAttributeDetailDTOList);
    }
  }

  _getImageList(
      CreateCategoryProductAttributeDTO
          createCategoryProductAttributeDTO) async {
    var resultList = await MultiImagePicker.pickImages(
      maxImages: 5 - this.imageList.length,
      enableCamera: true,
    );

    // The data selected here comes back in the list
    print(resultList);

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

  setProdAttributesForAllLobs(
      List<CreateCategoryProductAttributeDTO>
          createCategoryProductAttributeDTOList,
      ProductDTO productDTO) {
    for (int i = 0; i < createCategoryProductAttributeDTOList.length; i++) {
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO =
          createCategoryProductAttributeDTOList[i];

      createCategoryProductAttributeDTO.productAttributeDetailDTO.valueType =
          "VARCHAR";
      if(createCategoryProductAttributeDTO.productAttributeDetailDTO.attributeName == 'Product Name'){
            productDTO.productName = createCategoryProductAttributeDTO
                .productAttributeDetailDTO.value;
      }
      switch (createCategoryProductAttributeDTO
          .productAttributeDetailDTO.displayType) {
        case "name":
          {
            print(
                'name setted as ${createCategoryProductAttributeDTO.productAttributeDetailDTO.value}');
            productDTO.productName = createCategoryProductAttributeDTO
                .productAttributeDetailDTO.value;
          }
          break;
        case "images":
          {
            productDTO.primaryImageUrl = this.imageList.length > 0? this.imageList[0].imageUrl :null;
          }
          break;
        case "City Type":
          {
            if (createCategoryProductAttributeDTO
                        .productAttributeDetailDTO.valuesList !=
                    null &&
                createCategoryProductAttributeDTO
                        .productAttributeDetailDTO.valuesList.length >
                    0)
              setCityTypeProdAttribute(
                  createCategoryProductAttributeDTO,
                  createCategoryProductAttributeDTO
                      .productAttributeDetailDTO.valuesList);
          }
          break;
        case "checkbox":
          {
            if (createCategoryProductAttributeDTO
                        .productAttributeDetailDTO.valuesList !=
                    null &&
                createCategoryProductAttributeDTO
                        .productAttributeDetailDTO.valuesList.length >
                    0)
              setCheckBoxAttributes(
                  createCategoryProductAttributeDTO,
                  createCategoryProductAttributeDTO.catProdAttrValues,
                  createCategoryProductAttributeDTO
                      .productAttributeDetailDTO.valuesList);
          }
          break;
        case "textarea":
        case "description":
          {
            createCategoryProductAttributeDTO
                .productAttributeDetailDTO.valueType = "BLOB";
          }
          break;
        case "price":
          {
            setPriceList(
                createCategoryProductAttributeDTO.productAttributeDetailDTO);
          }
          break;
        case "Delivery Schedule":
          {
            setDeliveryScheduleTerms(
                createCategoryProductAttributeDTO.productAttributeDetailDTO,
                null,
                createCategoryProductAttributeDTO
                    .productAttributeDetailDTO.startTime,
                createCategoryProductAttributeDTO
                    .productAttributeDetailDTO.endTime,
                createCategoryProductAttributeDTO
                    .productAttributeDetailDTO.selectedPeriod);
          }
          break;
        default:
          {
            print("Invalid choice");
          }
          break;
      }
      if (["City Type", "checkbox"].indexOf(createCategoryProductAttributeDTO
              .productAttributeDetailDTO.displayType) ==
          -1) {
        print('---------------------');
        print(jsonEncode(
            createCategoryProductAttributeDTO.productAttributeDetailDTO));
        print('---------------------');
        this
            .productAttributeDetailDTOList
            .add(createCategoryProductAttributeDTO.productAttributeDetailDTO);
      }
    }
  }

  ProductDTO saveProduct() {
    print("save product called...!");
    ProductDTO productDTO = new ProductDTO();
    productDTO.productOptionDTO = [];
    setProdAttributesForAllLobs(
        widget.productAttributes.listCatProdAttrLoBRespDTO
            .createCategoryProductAttributeDTO,
        productDTO);
    if (widget.productAttributes.listCatProdAttrLoBRespDTO.catProdAttrLoBListDTO
            .length >
        0) {
      for (int i = 0;
          i <
              widget.productAttributes.listCatProdAttrLoBRespDTO
                  .catProdAttrLoBListDTO.length;
          i++) {
        print("looped");
        setProdAttributesForAllLobs(
            widget.productAttributes.listCatProdAttrLoBRespDTO
                .catProdAttrLoBListDTO[i].createCategoryProductAttributeDTO,
            productDTO);
      }
    }
    print("step2");
    print(this.productAttributeDetailDTOList);
    print(productDTO.productName == null);
    productDTO.productName = productDTO.productName;
    productDTO.type = "product";
    productDTO.channel = "B2BInternational"; //need to change
    productDTO.region = "IN"; //need to change
    productDTO.hsCodes = [];
    HsCodes hs = new HsCodes();
    hs.hscode = "00000000";
    hs.countryCode = "ZZ";
    hs.direction = "B";
    hs.lobId = null;
    productDTO.status = "Created";
    productDTO.hsCodes.add(hs);
    productDTO.categoryIds = [widget.categoryRegionLob.categoryId];
    productDTO.selectedSites = [];
    productDTO.supplierId = widget.user.companyId;
    print(widget.user.companyId);
    print("bf22e74d-e21f-4549-a3ef-a52e22350ffc");
    productDTO.productAttributeDetailDTO = productAttributeDetailDTOList;
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
    print("details dtos");
    print(jsonEncode(this.priceList));
    print(jsonEncode(this.imageList));
    print("Custom length ${this.customList.length}");
    for (var item in this.priceList) {
      print(jsonEncode(item));
    }

    if (this.customList.length > 0) {
      for (ProductAttributeDetailDTO item in this.customList) {
        print(jsonEncode(item));
        if (item.attributeName != null && item.value != null) {
          this.productAttributeDetailDTOList.add(item);
        }
      }
    }
    ProductOptionDTO productOptionDTO = ProductOptionDTO();
    productOptionDTO.productOptionName = productDTO.productName;
    productOptionDTO.productAttributeDetailDTO = [];
    productOptionDTO.priceList = [];
    productOptionDTO.imageDTO = [];
    productOptionDTO.priceList = this.priceList;
    productOptionDTO.deliveryScheduleDTO = [];
    productOptionDTO.imageDTO = this.imageList;
    productOptionDTO.start = DateFormat('yyyy-MM-dd').format(DateTime.now());
    productDTO.productOptionDTO.add(productOptionDTO);
    productDTO.faqs = this.faqs;
    productOptionDTO.deliveryScheduleDTO = this.deliveryScheduleDTOList;
    print("final productDto is");

    print(jsonEncode(productDTO.productName));
    print(this.imageList.length);
    print(jsonEncode(this.priceList));
    print(jsonEncode(this.deliveryScheduleDTOList));
    print(jsonEncode(productDTO.productOptionDTO));
    return productDTO;
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
        this.countryCodesList = List<Country>.from(
            countryCodes.map((data) => Country.fromJson(data))).toList();
      });
    });
  }

  setCheckBoxAttributes(
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO,
      List<CatProdAttrValues> catProdAttrValues,
      var values) {
    if (values.length > 0 && catProdAttrValues.length > 0) {
      for (var catProd in catProdAttrValues) {
        for (var val in values) {
          if (val.toString() == catProd.name) {
            setProductAttribute(
                createCategoryProductAttributeDTO, catProd.value.toString());
          }
        }
      }
    }
  }

  setPriceList(ProductAttributeDetailDTO productAttributeDetailDTO) {
    if(productAttributeDetailDTO.unitType != null &&
    productAttributeDetailDTO.unitType.unit != null ){
      for (var price in productAttributeDetailDTO.price.priceList) {
      price.currency = productAttributeDetailDTO.currency;
      price.unitType = productAttributeDetailDTO.unitType.unit;
      price.lobId = productAttributeDetailDTO.lobId;
      setDeliveryScheduleTerms(productAttributeDetailDTO, price.priceType,
          price.edcStart, price.edcEnd, price.edcSelectedTime);
      for (var priceSlab in price.productPriceSlabs) {
        priceSlab.qtyEnd = priceSlab.rangeStart.toString();
        priceSlab.priceStart = priceSlab.price;
        priceSlab.qtyStart = '1';
      }
      this.priceList.add(price);
      if (productAttributeDetailDTO.minOrderQty != null) {
        setProdAttr(productAttributeDetailDTO, "Minimum Order Qty",
            "${productAttributeDetailDTO.minOrderQty} ${price.unitType}");
      }
      if (productAttributeDetailDTO.perUnitWeight != null) {
        setProdAttr(productAttributeDetailDTO, "Per Unit Weight In kg's",
            productAttributeDetailDTO.perUnitWeight);
      }
    }
    }
    
  }

  setProdAttr(
      ProductAttributeDetailDTO productAttributeDetailDTO, attrName, value) {
    ProductAttributeDetailDTO productAttributeDTO =
        new ProductAttributeDetailDTO();
    productAttributeDTO.valueType = "VARCHAR";
    productAttributeDTO.value = value;
    productAttributeDTO.attributeName = attrName;
    productAttributeDTO.lobId = productAttributeDetailDTO.lobId;
    print("before setProdAttr");
    print(attrName);
    print(value);
    print(jsonEncode(productAttributeDTO));
    this.productAttributeDetailDTOList.add(productAttributeDTO);
  }

  setCustomAttr() {
    ProductAttributeDetailDTO prodAttr = new ProductAttributeDetailDTO();
    prodAttr.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
    prodAttr.valueType = "VARCHAR";
    this.customList.add(prodAttr);
  }

  setDeliveryScheduleTerms(ProductAttributeDetailDTO productAttributeDetailDTO,
      String incoterm, String start, String end, String days) {
        if(start !=null && end !=null && days !=null ){
              print("setDeliveryScheduleTerms called");
              print("start $start");
              print("end $end");
              print("days $days");
              DeliveryScheduleDTO deliveryScheduleDTO = DeliveryScheduleDTO();
              deliveryScheduleDTO.minValue = num.parse(start);
              deliveryScheduleDTO.maxValue = num.parse(end);
              deliveryScheduleDTO.incoTerms = incoterm;
              deliveryScheduleDTO.unitType = days;
              deliveryScheduleDTO.attributeName = productAttributeDetailDTO.attributeName;
              if (productAttributeDetailDTO.displayType == 'Delivery Schedule') {
                deliveryScheduleDTO.attributeId =
                    productAttributeDetailDTO.prodAttrId != null
                        ? productAttributeDetailDTO.prodAttrId
                        : productAttributeDetailDTO.productAttributeId;
              }
              deliveryScheduleDTO.lobId = productAttributeDetailDTO.lobId;
              this.deliveryScheduleDTOList.add(deliveryScheduleDTO);
                  }
   
  }

  Widget _getDisplayTypes(
      List<CreateCategoryProductAttributeDTO> createCategoryProductAttributeDTO,
      BuildContext context,
      lobId) {
       
    return new Container(
       margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
                border: Border.all(),
              ),
      child: new Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
               Container(
                 alignment: Alignment.center,
             padding: EdgeInsets.all(10) ,
              decoration: BoxDecoration(
                color: Colors.lightGreen
                                            // border: Border(
                                            //   bottom: BorderSide(
                                            //       color: Colors.grey),
                                            // ),
                                          ),
              // color: Colors.lightGreen,
              child: Text(lobId == "34343e34-7601-40de-878d-01b3bd1f0641"
                  ? "MarketPlace - Global"
                  : lobId == "34343e34-7601-40de-878d-01b3bd1f0642"
                      ? "BLISS - Domestic"
                      : lobId == "34343e34-7601-40de-878d-01b3bd1f0643"
                          ? "BLISS - Global"
                          : lobId == "34343e34-7601-40de-878d-01b3bd1f0644"
                              ? "MarketPlace - Domestic"
                              : "All",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            
          
          createCategoryProductAttributeDTO.length>0 ?  ListView.builder(
              padding: EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: createCategoryProductAttributeDTO.length,
              itemBuilder: (context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row( 
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                          child: Text(createCategoryProductAttributeDTO[index]
                            .productAttributeDTO
                            .name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                            ),
                        ),
                          createCategoryProductAttributeDTO[index]
                          .catgryProductAttributeDTO.required ?  Container(
                            child: Text('required',style: TextStyle(color: Colors.grey),),
                          ):Container()
                      ],
                    ),

                    (createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "text" ||
                            createCategoryProductAttributeDTO[index]
                                    .catgryProductAttributeDTO
                                    .displayType ==
                                "email" ||
                            createCategoryProductAttributeDTO[index]
                                    .catgryProductAttributeDTO
                                    .displayType ==
                                "number" ||
                            createCategoryProductAttributeDTO[index]
                                    .catgryProductAttributeDTO
                                    .displayType ==
                                "url" ||
                            createCategoryProductAttributeDTO[index]
                                    .catgryProductAttributeDTO
                                    .displayType ==
                                "name")
                        ? Container(
                            padding: EdgeInsets.all(10),
                            // margin: EdgeInsets.all(10),
                            child: TextFormField(
                                keyboardType: createCategoryProductAttributeDTO[index]
                                            .catgryProductAttributeDTO
                                            .displayType ==
                                        "email"
                                    ? TextInputType.emailAddress
                                    : createCategoryProductAttributeDTO[index]
                                                .catgryProductAttributeDTO
                                                .displayType ==
                                            "url"
                                        ? TextInputType.url
                                        : createCategoryProductAttributeDTO[index]
                                                    .catgryProductAttributeDTO
                                                    .displayType ==
                                                "number"
                                            ? TextInputType.number
                                            : TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        createCategoryProductAttributeDTO[index]
                                            .productAttributeDTO
                                            .name
                                            .toString(),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8))),
                                initialValue: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.value,
                                validator: (arg1) {
                                  print("validator called..$arg1");
                                  createCategoryProductAttributeDTO[index]
                                      .productAttributeDetailDTO
                                      .value = arg1;
                                  // if(createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="email"){
                                  //   return !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(arg1)?"Enter Valid Email":null;
                                  // }else if(createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="url"){
                                  //   return !RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)').hasMatch(arg1)?"Enter Valid Email":null;
                                  // }
                                  return null;
                                },
                                onChanged: (String value) {
                                  print(value);
                                  createCategoryProductAttributeDTO[index]
                                      .productAttributeDetailDTO
                                      .value = value;
                                  print(createCategoryProductAttributeDTO[index]
                                      .productAttributeDetailDTO
                                      .value);
                                }),
                          )
                        : createCategoryProductAttributeDTO[index]
                                    .catgryProductAttributeDTO
                                    .displayType ==
                                "images"
                            ? Container(
                                height:
                                    imageList.length > 0 && imageList.length < 5
                                        ? 140
                                        : imageList.length == 5 ? 100 : 50,
                                child: Column(
                                  children: <Widget>[
                                    imageList.length > 0
                                        ? GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 5,
                                            childAspectRatio: 1,
                                            children: List.generate(
                                                imageList.length, (index) {
                                              if (imageList.length > 0) {
                                                ImageDTO uploadModel =
                                                    imageList[index];
                                                return Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Image.network(
                                                          '${Constants.envUrl}${Constants.mongoImageUrl}/${uploadModel.imageUrl}',
                                                          width: 300,
                                                          height: 300,
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          top: 0,
                                                          child: InkWell(
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              size: 20,
                                                              color: Colors.red,
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                imageList
                                                                    .removeAt(
                                                                        index);
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
                                                      icon: Icon(Icons.add),
                                                      onPressed: () {
                                                        _getImageList(
                                                            createCategoryProductAttributeDTO[
                                                                index]);
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
                                              _getImageList(
                                                  createCategoryProductAttributeDTO[
                                                      index]);
                                            },
                                            icon: Icon(Icons.library_add))
                                        : Container(),
                                  ],
                                ),
                              )
                            : createCategoryProductAttributeDTO[index]
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
                                        hintText:
                                            createCategoryProductAttributeDTO[
                                                    index]
                                                .productAttributeDTO
                                                .name
                                                .toString(),
                                      ),
                                      onChanged: (DateTime val) {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        setState(() {
                                           createCategoryProductAttributeDTO[index]
                                            .productAttributeDetailDTO
                                            .value =  val !=null ?val.toUtc().toString():null;
                                        });
                                      },
                                      validator: (val) {
                                        print("date is");
                                       
                                        return null;
                                      },
                                      format: DateFormat("yyyy-MM-dd"),
                                      onShowPicker: (context, currentValue) {
                                        return showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            lastDate: DateTime(2100));
                                      },
                                    ))
                                : createCategoryProductAttributeDTO[index]
                                            .catgryProductAttributeDTO
                                            .displayType ==
                                        "City Type"
                                    ? Container(
                                        child: SearchableDropdown.multiple(
                                          displayClearIcon: false,
                                          items: citiesList
                                              .map((CityDetails cityDetail) {
                                            return DropdownMenuItem<
                                                CityDetails>(
                                              value: cityDetail,
                                              child: Text(cityDetail.village),
                                            );
                                          }).toList(),
                                          selectedItems:
                                              createCategoryProductAttributeDTO[
                                                      index]
                                                  .productAttributeDetailDTO
                                                  .valuesList,
                                          hint:
                                              createCategoryProductAttributeDTO[
                                                      index]
                                                  .productAttributeDTO
                                                  .name,
                                          searchHint:
                                              createCategoryProductAttributeDTO[
                                                      index]
                                                  .productAttributeDTO
                                                  .name,
                                          onChanged: (value) {
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            setState(() {
                                              print("city on changed");
                                              print(value);
                                              // choosenCities = value;
                                              createCategoryProductAttributeDTO[
                                                      index]
                                                  .productAttributeDetailDTO
                                                  .valuesList = value;
                                            });
                                          },
                                          dialogBox: true,
                                          closeButton: (choosenCities) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                RaisedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        choosenCities.clear();
                                                        choosenCities.addAll(
                                                            Iterable<int>.generate(
                                                                    citiesList
                                                                        .length)
                                                                .toList());
                                                      });
                                                    },
                                                    child: Text("Select all")),
                                                RaisedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        choosenCities.clear();
                                                      });
                                                    },
                                                    child:
                                                        Text("Deselect all")),
                                              ],
                                            );
                                          },
                                          isExpanded: true,
                                        ),
                                      )
                                    : createCategoryProductAttributeDTO[index]
                                                .catgryProductAttributeDTO
                                                .displayType ==
                                            "checkbox"
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            child: CheckboxGroup(
                                              labels: List<String>.from(
                                                  createCategoryProductAttributeDTO[
                                                          index]
                                                      .catProdAttrValues
                                                      .map((data) {
                                                return data.name.toString();
                                              })).toList(),
                                              onSelected:
                                                  (List<String> checked) {
                                                print(checked.toString());
                                                createCategoryProductAttributeDTO[
                                                        index]
                                                    .productAttributeDetailDTO
                                                    .valuesList = checked;
                                              },
                                            ),
                                          )
                                        : createCategoryProductAttributeDTO[index]
                                                    .catgryProductAttributeDTO
                                                    .displayType ==
                                                "radio"
                                            ? Container(
                                                padding: EdgeInsets.all(10),
                                                child: RadioButtonGroup(
                                                    labels: List<String>.from(
                                                        createCategoryProductAttributeDTO[
                                                                index]
                                                            .catProdAttrValues
                                                            .map((data) {
                                                      return data.name
                                                          .toString();
                                                    })).toList(),
                                                    onSelected:
                                                        (String selected) {
                                                      print(selected);
                                                      for (CatProdAttrValues catProd
                                                          in createCategoryProductAttributeDTO[
                                                                  index]
                                                              .catProdAttrValues) {
                                                        if (catProd.name ==
                                                            selected) {
                                                          createCategoryProductAttributeDTO[
                                                                      index]
                                                                  .productAttributeDetailDTO
                                                                  .value =
                                                              catProd.value;
                                                          createCategoryProductAttributeDTO[
                                                                      index]
                                                                  .productAttributeDetailDTO
                                                                  .selectedItem =
                                                              catProd.value;
                                                        }
                                                      }
                                                    }),
                                              )
                                            : createCategoryProductAttributeDTO[index]
                                                        .catgryProductAttributeDTO
                                                        .displayType ==
                                                    "select"
                                                ? Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: new DropdownButton<
                                                        CatProdAttrValues>(
                                                      value: createCategoryProductAttributeDTO[
                                                              index]
                                                          .productAttributeDetailDTO
                                                          .catProdAttrValue,
                                                      items: createCategoryProductAttributeDTO[
                                                              index]
                                                          .catProdAttrValues
                                                          .map(
                                                              (CatProdAttrValues
                                                                  value) {
                                                        return new DropdownMenuItem<
                                                            CatProdAttrValues>(
                                                          value: value,
                                                          child: new Text(
                                                              value.name),
                                                        );
                                                      }).toList(),
                                                      isExpanded: true,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                          print(val);
                                                          print(val.value);
                                                          createCategoryProductAttributeDTO[
                                                                  index]
                                                              .productAttributeDetailDTO
                                                              .value = val.value;
                                                          createCategoryProductAttributeDTO[
                                                                  index]
                                                              .productAttributeDetailDTO
                                                              .catProdAttrValue = val;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "search and select"
                                                    ? Container(
                                                        child:
                                                            SearchableDropdown
                                                                .single(
                                                          displayClearIcon:
                                                              false,
                                                          items: createCategoryProductAttributeDTO[
                                                                  index]
                                                              .catProdAttrValues
                                                              .map(
                                                                  (CatProdAttrValues
                                                                      value) {
                                                            return new DropdownMenuItem<
                                                                CatProdAttrValues>(
                                                              value: value,
                                                              child: new Text(
                                                                  value.name),
                                                            );
                                                          }).toList(),
                                                          value: createCategoryProductAttributeDTO[
                                                                  index]
                                                              .productAttributeDetailDTO
                                                              .catProdAttrValue,
                                                          hint: createCategoryProductAttributeDTO[
                                                                  index]
                                                              .productAttributeDTO
                                                              .name,
                                                          searchHint:
                                                              "Select one",
                                                          onChanged: (value) {
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            print(
                                                                "search and select");
                                                            print(value);
                                                            createCategoryProductAttributeDTO[
                                                                        index]
                                                                    .productAttributeDetailDTO
                                                                    .value =
                                                                value.value;
                                                            // selectedValue = value;

                                                            createCategoryProductAttributeDTO[
                                                                    index]
                                                                .productAttributeDetailDTO
                                                                .catProdAttrValue = value;
                                                          },
                                                          isExpanded: true,
                                                          validator: (val) {
                                                            print(
                                                                "search and select");
                                                            print(val);
                                                          },
                                                        ),
                                                      )
                                                    : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "year"
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child:
                                                                new DropdownButton<
                                                                    String>(
                                                              value: createCategoryProductAttributeDTO[
                                                                      index]
                                                                  .productAttributeDetailDTO
                                                                  .value,
                                                              items: List<
                                                                      String>.generate(
                                                                  num.parse(createCategoryProductAttributeDTO[index]
                                                                          .catProdAttrValues[
                                                                              0]
                                                                          .value) -
                                                                      num.parse(createCategoryProductAttributeDTO[index]
                                                                          .catProdAttrValues[
                                                                              0]
                                                                          .name),
                                                                  (counter) =>
                                                                      (num.parse(createCategoryProductAttributeDTO[index].catProdAttrValues[0].name) +
                                                                              counter)
                                                                          .toString()).map(
                                                                  (String value) {
                                                                return new DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child:
                                                                      new Text(
                                                                          value),
                                                                );
                                                              }).toList(),
                                                              isExpanded: true,
                                                              onChanged:
                                                                  (year) {
                                                                setState(() {
                                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                                  print(year);
                                                                  createCategoryProductAttributeDTO[
                                                                          index]
                                                                      .productAttributeDetailDTO
                                                                      .value = year;
                                                                });
                                                              },
                                                            ),
                                                          )
                                                        : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "textarea" || createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "description"
                                                            ? Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child:
                                                                    TextFormField(
                                                                  maxLines: 4,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration: InputDecoration(
                                                                      contentPadding:
                                                                          EdgeInsets.fromLTRB(
                                                                              20,
                                                                              15,
                                                                              20,
                                                                              15),
                                                                      hintText: createCategoryProductAttributeDTO[
                                                                              index]
                                                                          .productAttributeDTO
                                                                          .name
                                                                          .toString(),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8))),
                                                                  validator:
                                                                      (arg1) {
                                                                    print(
                                                                        "validator called...$arg1");
                                                                    createCategoryProductAttributeDTO[
                                                                            index]
                                                                        .productAttributeDetailDTO
                                                                        .value = arg1;
                                                                    // setProductAttribute(createCategoryProductAttributeDTO[index], arg1);
                                                                    return null;
                                                                  },
                                                                ),
                                                              )
                                                            : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "file" || createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "certification"
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      child: IconButton(
                                                                          icon: Icon(Icons.add),
                                                                          onPressed: () {
                                                                            getFilePickers(createCategoryProductAttributeDTO[index]);
                                                                          }),
                                                                    ),
                                                                  )
                                                                : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "Delivery Schedule"
                                                                    ? Container(
                                                                        padding: EdgeInsets.all(10),
                                                                        child: Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              child: new DropdownButton<String>(
                                                                                items: [
                                                                                  'Days',
                                                                                  'Weeks',
                                                                                  'Months'
                                                                                ].map((value) {
                                                                                  return new DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: new Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.selectedPeriod,
                                                                                isExpanded: true,
                                                                                onChanged: (period) {
                                                                                   FocusScope.of(context).requestFocus(FocusNode());
                                                                                  setState(() {
                                                                                    print(period);
                                                                                    createCategoryProductAttributeDTO[index].productAttributeDetailDTO.selectedPeriod = period;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.all(5),
                                                                            ),
                                                                            Expanded(
                                                                              child: TextFormField(
                                                                                decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'Start', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                validator: (start) {
                                                                                  createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                  // saveDeliverySchedule(createCategoryProductAttributeDTO[index],arg1,'Start');
                                                                                  return null;
                                                                                },
                                                                                onChanged: (start) {
                                                                                  createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                  // saveDeliverySchedule(createCategoryProductAttributeDTO[index],arg1,'Start');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.all(5),
                                                                              child: Text('-'),
                                                                            ),
                                                                            Expanded(
                                                                              child: TextFormField(
                                                                                decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'End', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                validator: (end) {
                                                                                  createCategoryProductAttributeDTO[index].productAttributeDetailDTO.endTime = end;
                                                                                  //  saveDeliverySchedule(createCategoryProductAttributeDTO[index],arg1,'End');
                                                                                  return null;
                                                                                },
                                                                                onChanged: (end) {
                                                                                  createCategoryProductAttributeDTO[index].productAttributeDetailDTO.endTime = end;
                                                                                  //  saveDeliverySchedule(createCategoryProductAttributeDTO[index],arg1,'End');
                                                                                  return null;
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ))
                                                                    : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "price"
                                                                        ? Container(
                                                                            padding:
                                                                                EdgeInsets.all(10),
                                                                            child:
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                                                                              Container(
                                                                                child: Text('Unit of Measurement'),
                                                                                padding: EdgeInsets.all(10),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: DropdownButton(
                                                                                  hint: Text('select UOM'),
                                                                                  isExpanded: true,
                                                                                  value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.uom,
                                                                                  iconSize: 30.0,
                                                                                  items: this.uomsList.map(
                                                                                    (val) {
                                                                                      return DropdownMenuItem<UomDTO>(
                                                                                        value: val,
                                                                                        child: Text(val.unit),
                                                                                      );
                                                                                    },
                                                                                  ).toList(),
                                                                                  onChanged: (val) {
                                                                                    setState(
                                                                                      () {
                                                                                      FocusScope.of(context).requestFocus(FocusNode());

                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.uom = val;
                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType = new UnitType();
                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType.unit = val.unit.toString();
                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType.description = val.description.toString();
                                                                                        print(jsonEncode(val));
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(padding: EdgeInsets.all(10), child: Text('Currency')),
                                                                              Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: DropdownButton(
                                                                                  hint: Text('select Currency'),
                                                                                  value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country,
                                                                                  isExpanded: true,
                                                                                  iconSize: 30.0,
                                                                                  items: this.countryCodesList.map(
                                                                                    (val) {
                                                                                      return DropdownMenuItem<Country>(
                                                                                        value: val,
                                                                                        child: Text(val.currency),
                                                                                      );
                                                                                    },
                                                                                  ).toList(),
                                                                                  onChanged: (val) {
                                                                                    setState(
                                                                                      () {
                                                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                                                        print(val);
                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency = val.currency;
                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country = val;
                                                                                        print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency);
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(padding: EdgeInsets.all(10), child: Text('Per Unit Weight In Kg \'s ')),
                                                                              Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: TextFormField(
                                                                                  decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'Per Unit Weight In Kg \'s ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                  validator: (perUnitWeight) {
                                                                                    setState(() {
                                                                                      createCategoryProductAttributeDTO[index].productAttributeDetailDTO.perUnitWeight = perUnitWeight;
                                                                                    });
                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (perUnitWeight) {
                                                                                    setState(() {
                                                                                      createCategoryProductAttributeDTO[index].productAttributeDetailDTO.perUnitWeight = perUnitWeight;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: Text('Minimum Order Quantity'),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: TextFormField(
                                                                                  decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'Minimum Order Quantity', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                  validator: (minOrderQuantity) {
                                                                                    print("validator called min order");
                                                                                    print(minOrderQuantity);
                                                                                    createCategoryProductAttributeDTO[index].productAttributeDetailDTO.minOrderQty = minOrderQuantity;

                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (String minOrderQuantity) {
                                                                                    setState(() {
                                                                                      print("onchanged called min order");
                                                                                      print(minOrderQuantity);
                                                                                      createCategoryProductAttributeDTO[index].productAttributeDetailDTO.minOrderQty = minOrderQuantity;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                children: <Widget>[
                                                                                  ListView.builder(
                                                                                      physics: const NeverScrollableScrollPhysics(),
                                                                                      shrinkWrap: true,
                                                                                      itemCount: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length,
                                                                                      itemBuilder: (BuildContext context, int priceList) {
                                                                                        // if(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.length ==0){createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.add(new ProductPriceSlabs());}
                                                                                        return Column(
                                                                                          children: <Widget>[
                                                                                            Container(
                                                                                              padding: EdgeInsets.all(10),
                                                                                              child: Text('Type of Pricing'),
                                                                                              alignment: Alignment.centerLeft,
                                                                                            ),
                                                                                            Container(
                                                                                              padding: EdgeInsets.only(left: 10),
                                                                                              child: Row(
                                                                                                children: <Widget>[
                                                                                                  Expanded(
                                                                                                    child: DropdownButton(
                                                                                                      hint: Text('select Price Type'),
                                                                                                      value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].selectedIncoterm,
                                                                                                      isExpanded: true,
                                                                                                      iconSize: 30.0,
                                                                                                      items: this.incotermsList.map(
                                                                                                        (val) {
                                                                                                          return DropdownMenuItem<IncotermDto>(
                                                                                                            value: val,
                                                                                                            child: Text(val.incoterm),
                                                                                                          );
                                                                                                        },
                                                                                                      ).toList(),
                                                                                                      onChanged: (val) {
                                                                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                                                                        setState(() {
                                                                                                          if (val.incoterm != null) {
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].priceType = val.incoterm;
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].selectedIncoterm = val;
                                                                                                            print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].priceType);
                                                                                                          } else {
                                                                                                            print('value not setted...!');
                                                                                                          }
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                   Container(
                                                                                                          child: ClipOval(
                                                                                                            child: Material(
                                                                                                              color: Colors.green, // button color
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.lightGreen, // inkwell color
                                                                                                                child: SizedBox(
                                                                                                                    width: 25,
                                                                                                                    height: 25,
                                                                                                                    child: Icon(
                                                                                                                     priceList == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length - 1 ? Icons.add : Icons.delete,
                                                                                                                      color: Colors.white,
                                                                                                                      size: 20,
                                                                                                                    )),
                                                                                                                onTap: () {
                                                                                                                  setState(() {
                                                                                                          print('tapped...!');
                                                                                                          print(jsonEncode(createCategoryProductAttributeDTO[index].productAttributeDetailDTO));
                                                                                                          if (priceList == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length - 1) {
                                                                                                            PriceList pr = new PriceList();
                                                                                                            pr.productPriceSlabs = [];
                                                                                                            pr.productPriceSlabs.add(new ProductPriceSlabs());
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.add(pr);
                                                                                                          } else {
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.removeAt(priceList);
                                                                                                          }
                                                                                                        });
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                /*   IconButton(
                                                                                                      icon: Icon(priceList == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length - 1 ? Icons.add : Icons.delete),
                                                                                                      onPressed: () {
                                                                                                        setState(() {
                                                                                                          print('tapped...!');
                                                                                                          print(jsonEncode(createCategoryProductAttributeDTO[index].productAttributeDetailDTO));
                                                                                                          if (priceList == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length - 1) {
                                                                                                            PriceList pr = new PriceList();
                                                                                                            pr.productPriceSlabs = [];
                                                                                                            pr.productPriceSlabs.add(new ProductPriceSlabs());
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.add(pr);
                                                                                                          } else {
                                                                                                            createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.removeAt(priceList);
                                                                                                          }
                                                                                                        });
                                                                                                      }) */
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              child: Text('Order Price'),
                                                                                              alignment: Alignment.centerLeft,
                                                                                              padding: EdgeInsets.all(10),
                                                                                            ),
                                                                                            Container(
                                                                                              child: ListView.builder(
                                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                                  shrinkWrap: true,
                                                                                                  itemCount: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.length,
                                                                                                  itemBuilder: (context2, int priceslab) {
                                                                                                    return Row(
                                                                                                      children: <Widget>[
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            padding: EdgeInsets.all(10),
                                                                                                            child: TextFormField(
                                                                                                              decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'Start', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                              validator: (arg1) {
                                                                                                                return null;
                                                                                                              },
                                                                                                              onChanged: (val) {
                                                                                                                print(val);
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text('-'),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            margin: EdgeInsets.all(5),
                                                                                                            child: TextFormField(
                                                                                                              decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'End', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                              validator: (arg1) {
                                                                                                                return null;
                                                                                                              },
                                                                                                              onChanged: (String val) {
                                                                                                                print('range start...!');
                                                                                                                print(val);
                                                                                                                createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs[priceslab].rangeStart = num.parse(val);
                                                                                                                print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs[priceslab].rangeStart);
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text('%'),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            margin: EdgeInsets.all(5),
                                                                                                            child: TextFormField(
                                                                                                              decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'Price', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                              validator: (arg1) {
                                                                                                                return null;
                                                                                                              },
                                                                                                              onChanged: (String val) {
                                                                                                                print('price start...!');
                                                                                                                print(val);
                                                                                                                createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs[priceslab].price = val;
                                                                                                                print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs[priceslab].price);
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Text(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.uom != null ? '/ ${createCategoryProductAttributeDTO[index].productAttributeDetailDTO.uom.unit}':''),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          child: ClipOval(
                                                                                                            child: Material(
                                                                                                              color: Colors.green, // button color
                                                                                                              child: InkWell(
                                                                                                                splashColor: Colors.lightGreen, // inkwell color
                                                                                                                child: SizedBox(
                                                                                                                    width: 25,
                                                                                                                    height: 25,
                                                                                                                    child: Icon(
                                                                                                                      priceslab == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.length - 1 ? Icons.add : Icons.delete,
                                                                                                                      color: Colors.white,
                                                                                                                      size: 20,
                                                                                                                    )),
                                                                                                                onTap: () {
                                                                                                                  setState(() {
                                                                                                                    print('tapped...!');
                                                                                                                    if (priceslab == createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.length - 1) {
                                                                                                                      createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.add(new ProductPriceSlabs());
                                                                                                                    } else {
                                                                                                                      createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.removeAt(priceslab);
                                                                                                                    }
                                                                                                                    print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].productPriceSlabs.length);
                                                                                                                  });
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    );
                                                                                                  }),
                                                                                            ),
                                                                                            Container(
                                                                                              child: Text('Order Delivery Time'),
                                                                                              alignment: Alignment.centerLeft,
                                                                                              padding: EdgeInsets.all(10),
                                                                                            ),
                                                                                            Container(
                                                                                              child: Row(
                                                                                                children: <Widget>[
                                                                                                  Expanded(
                                                                                                    child: new DropdownButton<String>(
                                                                                                      value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].edcSelectedTime != null ? createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].edcSelectedTime : null,
                                                                                                      items: [
                                                                                                        'Days',
                                                                                                        'Weeks',
                                                                                                        'Months'
                                                                                                      ].map((value) {
                                                                                                        return new DropdownMenuItem<String>(
                                                                                                          value: value,
                                                                                                          child: new Text(value),
                                                                                                        );
                                                                                                      }).toList(),
                                                                                                      isExpanded: true,
                                                                                                      onChanged: (period) {
                                                                                                        
                                                                                                        print(period);
                                                                                                         FocusScope.of(context).requestFocus(FocusNode());
                                                                                                        setState(() {
                                                                                                          if (period != null) createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].edcSelectedTime = period;
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    padding: EdgeInsets.all(5),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: TextFormField(
                                                                                                      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'Start', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                      validator: (start) {
                                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].edcStart = start;
                                                                                                        return null;
                                                                                                      },
                                                                                                      onChanged: (val) {
                                                                                                        print(val);
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    padding: EdgeInsets.all(5),
                                                                                                    child: Text('-'),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: TextFormField(
                                                                                                      decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'End', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                      validator: (end) {
                                                                                                        createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[priceList].edcEnd = end;
                                                                                                        return null;
                                                                                                      },
                                                                                                      onChanged: (val) {
                                                                                                        print(val);
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        );
                                                                                      })
                                                                                ],
                                                                              )
                                                                            ]),
                                                                          )
                                                                        : createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "hscode"
                                                                            ? Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    Row(
                                                                                      children: <Widget>[
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            child: DropdownButton(
                                                                                              hint: Text('country'),
                                                                                              value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country,
                                                                                              isExpanded: true,
                                                                                              iconSize: 30.0,
                                                                                              items: this.countryCodesList.map(
                                                                                                (val) {
                                                                                                  return DropdownMenuItem<Country>(
                                                                                                    value: val,
                                                                                                    child: Text(val.currency),
                                                                                                  );
                                                                                                },
                                                                                              ).toList(),
                                                                                              onChanged: (val) {
                                                                                                setState(
                                                                                                  () {
                                                                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                                                                    print(val);
                                                                                                    // createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency = val.currency;
                                                                                                    // createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country = val;
                                                                                                    // print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency);
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(5),
                                                                                        ),
                                                                                        Expanded(
                                                                                          flex: 2,
                                                                                          child: TextFormField(
                                                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'Search HS Codes', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                            validator: (start) {
                                                                                              createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                              return null;
                                                                                            },
                                                                                            onChanged: (start) {},
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(5),
                                                                                        ),
                                                                                        Container(
                                                                                          child: IconButton(
                                                                                              icon: Icon(Icons.search),
                                                                                              onPressed: () {
                                                                                                print("searching");
                                                                                              }),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                    ),
                                                                                    Row(
                                                                                      children: <Widget>[
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            child: DropdownButton(
                                                                                              hint: Text('country'),
                                                                                              value: createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country,
                                                                                              isExpanded: true,
                                                                                              iconSize: 30.0,
                                                                                              items: this.countryCodesList.map(
                                                                                                (val) {
                                                                                                  return DropdownMenuItem<Country>(
                                                                                                    value: val,
                                                                                                    child: Text(val.currency),
                                                                                                  );
                                                                                                },
                                                                                              ).toList(),
                                                                                              onChanged: (val) {
                                                                                                setState(
                                                                                                  () {
                                                                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                                                                    print(val);
                                                                                                    // createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency = val.currency;
                                                                                                    // createCategoryProductAttributeDTO[index].productAttributeDetailDTO.country = val;
                                                                                                    // print(createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency);
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(5),
                                                                                        ),
                                                                                        Expanded(
                                                                                          flex: 2,
                                                                                          child: TextFormField(
                                                                                            decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: 'Search HS Codes', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                            validator: (start) {
                                                                                              createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                              return null;
                                                                                            },
                                                                                            onChanged: (start) {},
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(5),
                                                                                        ),
                                                                                        Container(
                                                                                          child: IconButton(
                                                                                              icon: Icon(Icons.search),
                                                                                              onPressed: () {
                                                                                                print("searching");
                                                                                              }),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ))
                                                                            : Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                // margin: EdgeInsets.all(10),
                                                                                child: TextFormField(
                                                                                  decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: createCategoryProductAttributeDTO[index].productAttributeDTO.name.toString(), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                  validator: (arg1) {
                                                                                    return null;
                                                                                  },
                                                                                ))
                  ],
                );
              }):Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                child: Text('No attributes defined.')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Add Product'), backgroundColor: Constants.toolbarColor),
        body: ListView(
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _getDisplayTypes(
                        widget.productAttributes.listCatProdAttrLoBRespDTO
                            .createCategoryProductAttributeDTO,
                        context,
                        "34343e34-7601-40de-878d-01b3bd1f0640"),
                    Container(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget
                              .productAttributes
                              .listCatProdAttrLoBRespDTO
                              .catProdAttrLoBListDTO
                              .length,
                          itemBuilder: (BuildContext context, int catProds) {
                            return Column(
                              children: <Widget>[
                                _getDisplayTypes(
                                    widget
                                        .productAttributes
                                        .listCatProdAttrLoBRespDTO
                                        .catProdAttrLoBListDTO[catProds]
                                        .createCategoryProductAttributeDTO,
                                    context,
                                    widget
                                        .productAttributes
                                        .listCatProdAttrLoBRespDTO
                                        .catProdAttrLoBListDTO[catProds]
                                        .lobId),
                              ],
                            );
                          }),
                    ),
                    Container(
                      child: Text('Faqs'),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: this.faqs.length,
                              itemBuilder: (context, int faq) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 15, 20, 15),
                                              hintText: 'Question1',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          validator: (arg1) {
                                            return null;
                                          },
                                          onChanged: (val) {
                                            this.faqs[faq].question = val;
                                          },
                                        )),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.green, // button color
                                              child: InkWell(
                                                splashColor: Colors.lightGreen, // inkwell color
                                                child: SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: Icon(
                                                       this.faqs.length - 1 == faq ? Icons.add : Icons.delete,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                onTap: () {
                                                 setState(() {
                                                if (this.faqs.length - 1 ==
                                                    faq) {
                                                  this.faqs.add(new Faqs());
                                                } else {
                                                  this.faqs.removeAt(faq);
                                                }
                                              });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        /* Container(
                                          margin: EdgeInsets.all(10),
                                          child: IconButton(
                                            icon: Icon(
                                                this.faqs.length - 1 == faq
                                                    ? Icons.add
                                                    : Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                if (this.faqs.length - 1 ==
                                                    faq) {
                                                  this.faqs.add(new Faqs());
                                                } else {
                                                  this.faqs.removeAt(faq);
                                                }
                                              });
                                            },
                                          ),
                                        ) */
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                      child: TextFormField(
                                        maxLines: 4,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            hintText: 'Answer',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        validator: (arg1) {
                                          return null;
                                        },
                                        onChanged: (val) {
                                          this.faqs[faq].answer = val;
                                        },
                                      ),
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                    Container(
                      child: Text('Custom Attributes'),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: this.customList.length,
                              itemBuilder: (context, int custom) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 15, 20, 15),
                                              hintText: 'attribute name',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          validator: (arg1) {
                                            return null;
                                          },
                                          onChanged: (val) {
                                            this
                                                .customList[custom]
                                                .attributeName = val;
                                          },
                                        )),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.green, // button color
                                              child: InkWell(
                                                splashColor: Colors.lightGreen, // inkwell color
                                                child: SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: Icon(
                                                       this.customList.length - 1 == custom ? Icons.add : Icons.delete,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                onTap: () {
                                                 setState(() {
                                                if (this.customList.length -
                                                        1 ==
                                                    custom) {
                                                  setCustomAttr();
                                                } else {
                                                  this
                                                      .customList
                                                      .removeAt(custom);
                                                }
                                              });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                       /*  Container(
                                          margin: EdgeInsets.all(10),
                                          child: IconButton(
                                            icon: Icon(
                                                this.customList.length - 1 == custom
                                                       
                                                    ? Icons.add
                                                    : Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                if (this.customList.length -
                                                        1 ==
                                                    custom) {
                                                  setCustomAttr();
                                                } else {
                                                  this
                                                      .customList
                                                      .removeAt(custom);
                                                }
                                              });
                                            },
                                          ),
                                        ) */
                                      ],
                                    ),
                                    Container(
                                       margin: EdgeInsets.only(top:10),
                                        child: TextFormField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 15),
                                          hintText: 'attribute value',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      validator: (arg1) {
                                        return null;
                                      },
                                      onChanged: (val) {
                                        this.customList[custom].value = val;
                                      },
                                    )),
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
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
