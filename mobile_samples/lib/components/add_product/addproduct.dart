import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
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
  /* PriceList price = new PriceList();
  List<ProductPriceSlabs> productPriceSlabs;
  String start;
  String end;
  String cost;
  Map<String, String> priceMap; */

  @override
  void initState() {
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
    super.initState();
  }

  getFilePickers(
      CreateCategoryProductAttributeDTO
          createCategoryProductAttributeDTO) async {
    print("file pickers are called..!");
    List<File> files = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    print(files);

    for (var fileItem in files) {
      switch (fileItem.path.toString().substring(
          fileItem.path.toString().lastIndexOf('.'),
          fileItem.path.toString().length)) {
        case 'jpg':
        case 'jpeg':
        case 'JPG':
        case 'JPEG':
          mime.MediaType('image', 'jpeg');
          break;
      }
      print(fileItem.path);
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "${Constants.envUrl}/mongoupload/attachments/?Override=false"));
      request.files.add(await http.MultipartFile.fromPath(
        'attachments',
        fileItem.path,
        contentType: null,
      ));

      print("request is...!");
      print(request);
      var res = await request.send();
      final respStr = await res.stream.bytesToString();
      print("image upload ...");
      print(respStr);
      var imageInfo = json.decode(respStr)["fileName"];
      setProductAttribute(createCategoryProductAttributeDTO, imageInfo);
    }
  }

  _saveForm() async {
    var form = formKey.currentState;
    if (form.validate()) {
      // form.save();
      ProductDTO  productDTO=  saveProduct();
      print('hitting backend...');
      await catalogService.saveProduct(productDTO);
      setState(() {
        print("set state of save form");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home()));
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
      /* 
     print("before removing ");
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

  ProductDTO saveProduct() {
    print("save product called...!");
    ProductDTO productDTO = new ProductDTO();
    productDTO.productOptionDTO = [];
    print(this.productAttributeDetailDTOList);
   
   /* for(CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO in widget.productAttributes.listCatProdAttrLoBRespDTO
        .createCategoryProductAttributeDTO
        ){
      print('-------+--------');
      print(createCategoryProductAttributeDTO.productAttributeDetailDTO.displayType);
      createCategoryProductAttributeDTO.productAttributeDetailDTO.valueType = "VARCHAR";
      
      switch (createCategoryProductAttributeDTO.productAttributeDetailDTO.displayType) {
        case "name":
          {
            productDTO.productName = createCategoryProductAttributeDTO.productAttributeDetailDTO.value;
          }
          break;
        case "images":
          {
            productDTO.primaryImageUrl = this.imageList[0].imageUrl;
          }
          break;
        case "City Type":
          {
            setCityTypeProdAttribute(
                createCategoryProductAttributeDTO, createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList);
          }
          break;
        case "checkbox":
          {
            setCheckBoxAttributes(createCategoryProductAttributeDTO, createCategoryProductAttributeDTO.catProdAttrValues,
                createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList);
          }
          break;
        case "textarea":
        case "description":
          {
            createCategoryProductAttributeDTO.productAttributeDetailDTO.valueType = "BLOB";
          }
          break;
        case "price":
          {
            // setPriceList(createCategoryProductAttributeDTO.productAttributeDetailDTO);
          }
          break;
        case "Delivery Schedule":
          {
            // setDeliveryScheduleTerms(createCategoryProductAttributeDTO.productAttributeDetailDTO,null,createCategoryProductAttributeDTO.productAttributeDetailDTO.startTime,createCategoryProductAttributeDTO.productAttributeDetailDTO.endTime,createCategoryProductAttributeDTO.productAttributeDetailDTO.selectedPeriod);
          }
          break;
      
          
        default:
          {
            print("Invalid choice");
          }
          break;
      }
      if (["City Type", "checkbox"]
              .indexOf(createCategoryProductAttributeDTO.productAttributeDetailDTO.displayType) !=
          -1) {
        this.productAttributeDetailDTOList.add(createCategoryProductAttributeDTO.productAttributeDetailDTO);
      }
    } */
  
  for(int i=0;i<widget.productAttributes.listCatProdAttrLoBRespDTO
        .createCategoryProductAttributeDTO.length ;i++){
        CreateCategoryProductAttributeDTO  createCategoryProductAttributeDTO = widget.productAttributes.listCatProdAttrLoBRespDTO
        .createCategoryProductAttributeDTO[i];
           createCategoryProductAttributeDTO.productAttributeDetailDTO.valueType = "VARCHAR";
     
      switch (createCategoryProductAttributeDTO.productAttributeDetailDTO.displayType) {
        case "name":
          {
           print('name setted as ${createCategoryProductAttributeDTO.productAttributeDetailDTO.value}');
            productDTO.productName = createCategoryProductAttributeDTO.productAttributeDetailDTO.value;
          }
          break;
        case "images":
          {
            productDTO.primaryImageUrl = this.imageList[0].imageUrl;
          }
          break;
        case "City Type":
          {
            if(createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList !=null && createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList.length >0)
            setCityTypeProdAttribute(
                createCategoryProductAttributeDTO, createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList);
          }
          break;
        case "checkbox":
          {
             if(createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList !=null && createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList.length >0)
            setCheckBoxAttributes(createCategoryProductAttributeDTO, createCategoryProductAttributeDTO.catProdAttrValues,
                createCategoryProductAttributeDTO.productAttributeDetailDTO.valuesList);
          }
          break;
        case "textarea":
        case "description":
          {
            createCategoryProductAttributeDTO.productAttributeDetailDTO.valueType = "BLOB";
          }
          break;
        case "price":
          {
            setPriceList(createCategoryProductAttributeDTO.productAttributeDetailDTO);
          }
          break;
        case "Delivery Schedule":
          {
            setDeliveryScheduleTerms(createCategoryProductAttributeDTO.productAttributeDetailDTO,null,createCategoryProductAttributeDTO.productAttributeDetailDTO.startTime,createCategoryProductAttributeDTO.productAttributeDetailDTO.endTime,createCategoryProductAttributeDTO.productAttributeDetailDTO.selectedPeriod);
          }
          break;
      
          
        default:
          {
            print("Invalid choice");
          }
          break;
      }
      if (["City Type", "checkbox"]
              .indexOf(createCategoryProductAttributeDTO.productAttributeDetailDTO.displayType) ==
          -1) {
            print('---------------------');
            print(jsonEncode(createCategoryProductAttributeDTO.productAttributeDetailDTO));
             print('---------------------');
        this.productAttributeDetailDTOList.add(createCategoryProductAttributeDTO.productAttributeDetailDTO);
      }
         
  }
    print("step2");
    print(productDTO.productName == null);
    productDTO.productName = productDTO.productName == null ?'flutter dev3':productDTO.productName;
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
  
    productOptionDTO.deliveryScheduleDTO = this.deliveryScheduleDTOList;
    // if(this.deliveryScheduleDTOList.length >0){
    //    ProductOptionDTO productOptionDTODup = productOptionDTO;
    //     productOptionDTODup.priceList = [];
    //     productOptionDTODup.deliveryScheduleDTO = this.deliveryScheduleDTOList;
    //     productOptionDTODup.imageDTO = []; 
    //    productDTO.productOptionDTO.add(productOptionDTODup);

    // }
    
 
        print("final productDto is");
       
        print(jsonEncode(productDTO.productName));
        print(this.imageList.length);
         print(this.priceList.length);
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
           
            setProductAttribute(createCategoryProductAttributeDTO,
               catProd.value.toString());
          }

        }
      }
      // for (int i = 0; i < values.length; i++) {
      //   for (int j = 0; i < catProdAttrValues.length; j++) {
      //      print('index--$i');
      //     print(values[i].toString());
      //      print(catProdAttrValues[j].name);
      //     if (values[i].toString() == catProdAttrValues[j].name) {
           
      //       setProductAttribute(createCategoryProductAttributeDTO,
      //           catProdAttrValues[j].value.toString());
      //     }
      //   }
      // }
    }
  }

  setPriceList(ProductAttributeDetailDTO productAttributeDetailDTO) {
    for (var price in productAttributeDetailDTO.price.priceList) {
      price.currency = productAttributeDetailDTO.currency;
      price.unitType=  productAttributeDetailDTO.unitType.unit;
      price.lobId= productAttributeDetailDTO.lobId;
       setDeliveryScheduleTerms(productAttributeDetailDTO,price.unitType,price.edcStart,price.edcEnd,price.edcSelectedTime);
       for (var priceSlab in price.productPriceSlabs) {
          priceSlab.qtyEnd = priceSlab.rangeStart.toString();
           priceSlab.priceStart = priceSlab.price;
            priceSlab.qtyStart = '1';
       }
      this.priceList.add(price);
      if(productAttributeDetailDTO.minOrderQty != null){
          setProdAttr( productAttributeDetailDTO,"Minimum Order Qty",productAttributeDetailDTO.minOrderQty);
      }else if(productAttributeDetailDTO.perUnitWeight != null){
          setProdAttr( productAttributeDetailDTO,"Per Unit Weight In kg's",productAttributeDetailDTO.perUnitWeight);
      }
    }
    // this.priceList.addAll(productAttributeDetailDTO.price.priceList);
  }
  setProdAttr(ProductAttributeDetailDTO productAttributeDetailDTO,attrName,value){
    ProductAttributeDetailDTO productAttributeDTO = new ProductAttributeDetailDTO();
    productAttributeDTO.valueType= "VARCHAR" ;
    productAttributeDTO.value= value;
    productAttributeDTO.attributeName= attrName;
    productAttributeDTO.lobId= productAttributeDetailDTO.lobId;
    this.productAttributeDetailDTOList.add(productAttributeDTO);

  }
  setDeliveryScheduleTerms(
      ProductAttributeDetailDTO productAttributeDetailDTO,String incoterm, String start,String end,String days) {
       DeliveryScheduleDTO deliveryScheduleDTO = DeliveryScheduleDTO();
        deliveryScheduleDTO.minValue = num.parse(start);
        deliveryScheduleDTO.maxValue= num.parse(end);
        deliveryScheduleDTO.incoTerms= incoterm;
       deliveryScheduleDTO.unitType = days;
        deliveryScheduleDTO.attributeName= productAttributeDetailDTO.attributeName;
        deliveryScheduleDTO.lobId= productAttributeDetailDTO.lobId;
        this.deliveryScheduleDTOList.add(deliveryScheduleDTO);

      }
  /* saveDeliverySchedule(
      CreateCategoryProductAttributeDTO createCategoryProductAttributeDTO,
      var value,
      String type) {
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
    if (type == 'Start') {
      productAttributeDetailDTO.startTime = value;
    } else if (type == 'End') {
      productAttributeDetailDTO.endTime = value;
    } else if (type == 'Period') {
      productAttributeDetailDTO.selectedPeriod = value;
    }
    if (productAttributeDetailDTO.startTime != null &&
        productAttributeDetailDTO.endTime != null &&
        productAttributeDetailDTO.selectedPeriod != null) {
      print('Delivery terms are added successfully..!');
      this.productAttributeDetailDTOList.add(productAttributeDetailDTO);
    }
  } */

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
                              (widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "text" ||
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
                                          "url" ||
                                      widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .catgryProductAttributeDTO
                                              .displayType ==
                                          "name")
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
                                        initialValue: widget
                                            .productAttributes
                                            .listCatProdAttrLoBRespDTO
                                            .createCategoryProductAttributeDTO[
                                                index]
                                            .productAttributeDetailDTO
                                            .value,
                                        validator: (arg1) {
                                          print("validator called..$arg1");
                                          widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .productAttributeDetailDTO
                                              .value = arg1;
                                          // setProductAttribute(
                                          //     widget
                                          //             .productAttributes
                                          //             .listCatProdAttrLoBRespDTO
                                          //             .createCategoryProductAttributeDTO[
                                          //         index],
                                          //     arg1);
                                          // if(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="email"){
                                          //   return !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(arg1)?"Enter Valid Email":null;
                                          // }else if(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="url"){
                                          //   return !RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)').hasMatch(arg1)?"Enter Valid Email":null;
                                          // }
                                          return null;
                                        },
                                         onChanged: (String value) {
                                           print(value);
                                         widget
                                              .productAttributes
                                              .listCatProdAttrLoBRespDTO
                                              .createCategoryProductAttributeDTO[
                                                  index]
                                              .productAttributeDetailDTO
                                              .value = value;
                                         }
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
                                  : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType ==
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
                                                onChanged: (DateTime val) {
                                                  print(val.toUtc());
                                                },
                                                validator: (val) {
                                                  print("date is");
                                                  print(val.toUtc());
                                                  widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[
                                                          index]
                                                      .productAttributeDetailDTO
                                                      .value = val.toUtc().toString();
                                                  // setProductAttribute(
                                                  //     widget
                                                  //         .productAttributes
                                                  //         .listCatProdAttrLoBRespDTO
                                                  //         .createCategoryProductAttributeDTO[index],
                                                  //     val.toUtc().toString());

                                                  return null;
                                                },
                                                format:
                                                    DateFormat("yyyy-MM-dd"),
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          currentValue ??
                                                              DateTime.now(),
                                                      lastDate: DateTime(2100));
                                                },
                                              ))
                                          : widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[index]
                                                      .catgryProductAttributeDTO
                                                      .displayType ==
                                                  "City Type"
                                              ? Container(
                                                  child: SearchableDropdown
                                                      .multiple(
                                                    displayClearIcon: false,
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
                                                    selectedItems: widget
                                                        .productAttributes
                                                        .listCatProdAttrLoBRespDTO
                                                        .createCategoryProductAttributeDTO[
                                                            index]
                                                        .productAttributeDetailDTO
                                                        .valuesList,
                                                    hint: widget
                                                        .productAttributes
                                                        .listCatProdAttrLoBRespDTO
                                                        .createCategoryProductAttributeDTO[
                                                            index]
                                                        .productAttributeDTO
                                                        .name,
                                                    searchHint: widget
                                                        .productAttributes
                                                        .listCatProdAttrLoBRespDTO
                                                        .createCategoryProductAttributeDTO[
                                                            index]
                                                        .productAttributeDTO
                                                        .name,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        print(
                                                            "city on changed");
                                                        print(value);
                                                        // choosenCities = value;
                                                        widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .productAttributeDetailDTO
                                                            .valuesList = value;
                                                        // setCityTypeProdAttribute(
                                                        //     widget
                                                        //         .productAttributes
                                                        //         .listCatProdAttrLoBRespDTO
                                                        //         .createCategoryProductAttributeDTO[index],
                                                        //     choosenCities);
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
                                              : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "checkbox"
                                                  ? /* Container(
                                                      child: SearchableDropdown
                                                          .multiple(
                                                             displayClearIcon: false,
                                                        items: widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .catProdAttrValues
                                                            .map((CatProdAttrValues
                                                                catProdAttrValues) {
                                                          return DropdownMenuItem<
                                                              CatProdAttrValues>(
                                                            value:
                                                                catProdAttrValues,
                                                            child: Text(
                                                                catProdAttrValues
                                                                    .name),
                                                          );
                                                        }).toList(),
                                                        // selectedItems:choosenCities,
                                                        hint: widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .productAttributeDTO
                                                            .name,
                                                        searchHint: widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .productAttributeDTO
                                                            .name,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            print(
                                                                "Checkbox on changed");
                                                            print(value);
                                                             setCheckBoxAttributes(
                                                              widget
                                                                      .productAttributes
                                                                      .listCatProdAttrLoBRespDTO
                                                                      .createCategoryProductAttributeDTO[
                                                                  index],
                                                              widget
                                                                  .productAttributes
                                                                  .listCatProdAttrLoBRespDTO
                                                                  .createCategoryProductAttributeDTO[
                                                                      index]
                                                                  .catProdAttrValues,
                                                              value);
                                                          });
                                                        },
                                                        validator: (val) {
                                                          print("validator called in checkbox....!");
                                                         
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
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      choosenCities
                                                                          .clear();
                                                                      choosenCities
                                                                          .addAll(
                                                                              Iterable<int>.generate(citiesList.length).toList());
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      "Select all")),
                                                              RaisedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
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
                                                    ) */
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: CheckboxGroup(
                                                        labels: List<String>.from(widget
                                                            .productAttributes
                                                            .listCatProdAttrLoBRespDTO
                                                            .createCategoryProductAttributeDTO[
                                                                index]
                                                            .catProdAttrValues
                                                            .map((data) {
                                                          return data.name
                                                              .toString();
                                                        })).toList(),
                                                        onSelected:
                                                            (List<String>
                                                                checked) {
                                                          print(checked
                                                              .toString());
                                                          widget
                                                              .productAttributes
                                                              .listCatProdAttrLoBRespDTO
                                                              .createCategoryProductAttributeDTO[
                                                                  index]
                                                              .productAttributeDetailDTO
                                                              .valuesList = checked;
                                                          // setCheckBoxAttributes(
                                                          //     widget
                                                          //             .productAttributes
                                                          //             .listCatProdAttrLoBRespDTO
                                                          //             .createCategoryProductAttributeDTO[
                                                          //         index],
                                                          //     widget
                                                          //         .productAttributes
                                                          //         .listCatProdAttrLoBRespDTO
                                                          //         .createCategoryProductAttributeDTO[
                                                          //             index]
                                                          //         .catProdAttrValues,
                                                          //     checked);
                                                        },
                                                      ),
                                                    )
                                                  : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "radio"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              RadioButtonGroup(
                                                                  labels: List<String>.from(widget
                                                                      .productAttributes
                                                                      .listCatProdAttrLoBRespDTO
                                                                      .createCategoryProductAttributeDTO[
                                                                          index]
                                                                      .catProdAttrValues
                                                                      .map(
                                                                          (data) {
                                                                    return data
                                                                        .name
                                                                        .toString();
                                                                  })).toList(),
                                                                  onSelected:
                                                                      (String
                                                                          selected) {
                                                                    print(
                                                                        selected);
                                                                    widget
                                                                        .productAttributes
                                                                        .listCatProdAttrLoBRespDTO
                                                                        .createCategoryProductAttributeDTO[
                                                                            index]
                                                                        .productAttributeDetailDTO
                                                                        .value = selected;
                                                                    // setProductAttribute(
                                                                    //     widget
                                                                    //         .productAttributes
                                                                    //         .listCatProdAttrLoBRespDTO
                                                                    //         .createCategoryProductAttributeDTO[index],
                                                                    //     selected);
                                                                  }),
                                                        )
                                                      /* SearchableDropdown.single(
                                                          displayClearIcon:
                                                              false,
                                                          items: widget
                                                              .productAttributes
                                                              .listCatProdAttrLoBRespDTO
                                                              .createCategoryProductAttributeDTO[
                                                                  index]
                                                              .catProdAttrValues
                                                              .map((CatProdAttrValues
                                                                  catProdAttrValues) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  catProdAttrValues
                                                                      .value,
                                                              child: Text(
                                                                  catProdAttrValues
                                                                      .name),
                                                            );
                                                          }).toList(),
                                                          // value: selectedValue,
                                                          hint: "Select one",
                                                          searchHint:
                                                              "Select one",
                                                          onChanged: (value) {
                                                            setState(() {
                                                              print(value);
                                                              // selectedValue = value;
                                                            });
                                                          },
                                                          validator: (value) {
                                                            return null;
                                                          },
                                                          doneButton: "Done",
                                                          displayItem:
                                                              (item, selected) {
                                                            return (Row(
                                                                children: [
                                                                  selected
                                                                      ? Icon(
                                                                          Icons
                                                                              .radio_button_checked,
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .radio_button_unchecked,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                  SizedBox(
                                                                      width: 7),
                                                                  Expanded(
                                                                    child: item,
                                                                  ),
                                                                ]));
                                                          },
                                                          isExpanded: true,
                                                        ) */
                                                      : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "select"
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: new DropdownButton<
                                                                  CatProdAttrValues>(
                                                                items: widget
                                                                    .productAttributes
                                                                    .listCatProdAttrLoBRespDTO
                                                                    .createCategoryProductAttributeDTO[
                                                                        index]
                                                                    .catProdAttrValues
                                                                    .map((CatProdAttrValues
                                                                        value) {
                                                                  return new DropdownMenuItem<
                                                                      CatProdAttrValues>(
                                                                    value:
                                                                        value,
                                                                    child: new Text(
                                                                        value
                                                                            .name),
                                                                  );
                                                                }).toList(),
                                                                isExpanded:
                                                                    true,
                                                                onChanged:
                                                                    (val) {
                                                                  print(val);
                                                                  print(val
                                                                      .value);
                                                                  widget
                                                                      .productAttributes
                                                                      .listCatProdAttrLoBRespDTO
                                                                      .createCategoryProductAttributeDTO[
                                                                          index]
                                                                      .productAttributeDetailDTO
                                                                      .value = val.value;
                                                                  // setProductAttribute(
                                                                  //     widget
                                                                  //         .productAttributes
                                                                  //         .listCatProdAttrLoBRespDTO
                                                                  //         .createCategoryProductAttributeDTO[index],
                                                                  //     val);
                                                                },
                                                              ),
                                                            )
                                                          : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "search and select"
                                                              ? Container(
                                                                  child:
                                                                      SearchableDropdown
                                                                          .single(
                                                                    displayClearIcon:
                                                                        false,
                                                                    items: widget
                                                                        .productAttributes
                                                                        .listCatProdAttrLoBRespDTO
                                                                        .createCategoryProductAttributeDTO[
                                                                            index]
                                                                        .catProdAttrValues
                                                                        .map((CatProdAttrValues
                                                                            value) {
                                                                      return new DropdownMenuItem<
                                                                          CatProdAttrValues>(
                                                                        value:
                                                                            value,
                                                                        child: new Text(
                                                                            value.name),
                                                                      );
                                                                    }).toList(),
                                                                    // value: selectedValue,
                                                                    hint: widget
                                                                        .productAttributes
                                                                        .listCatProdAttrLoBRespDTO
                                                                        .createCategoryProductAttributeDTO[
                                                                            index]
                                                                        .productAttributeDTO
                                                                        .name,
                                                                    searchHint:
                                                                        "Select one",
                                                                    onChanged:
                                                                        (value) {
                                                                      
                                                                        print(
                                                                            "search and select");
                                                                        print(
                                                                            value);

                                                                        widget
                                                                            .productAttributes
                                                                            .listCatProdAttrLoBRespDTO
                                                                            .createCategoryProductAttributeDTO[index]
                                                                            .productAttributeDetailDTO
                                                                            .value = value.value;
                                                                        // selectedValue = value;
                                                                     
                                                                    },
                                                                    isExpanded:
                                                                        true,
                                                                    validator:
                                                                        (val) {
                                                                      print(
                                                                          "search and select");
                                                                      print(
                                                                          val);
                                                                      // widget
                                                                      //     .productAttributes
                                                                      //     .listCatProdAttrLoBRespDTO
                                                                      //     .createCategoryProductAttributeDTO[
                                                                      //         index]
                                                                      //     .productAttributeDetailDTO
                                                                      //     .value = val;
                                                                      // setProductAttribute(
                                                                      //     widget
                                                                      //         .productAttributes
                                                                      //         .listCatProdAttrLoBRespDTO
                                                                      //         .createCategoryProductAttributeDTO[index],
                                                                      //     val);
                                                                    },
                                                                  ),

                                                                  /*  SearchableDropdown
                                                                          .single(
                                                                    items: widget
                                                                        .productAttributes
                                                                        .listCatProdAttrLoBRespDTO
                                                                        .createCategoryProductAttributeDTO[
                                                                            index]
                                                                        .catProdAttrValues
                                                                        .map((CatProdAttrValues
                                                                            value) {
                                                                      return new DropdownMenuItem<
                                                                          CatProdAttrValues>(
                                                                        value:
                                                                            value,
                                                                        child: new Text(
                                                                            value.name),
                                                                      );
                                                                    }).toList(),
                                                                    // value: selectedValue,
                                                                    hint:
                                                                        "Select one",
                                                                    searchHint:
                                                                        null,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            value);
                                                                      });
                                                                    },
                                                                    validator:
                                                                        (val) {
                                                                      print(
                                                                          val);
                                                                      setProductAttribute(
                                                                          widget
                                                                              .productAttributes
                                                                              .listCatProdAttrLoBRespDTO
                                                                              .createCategoryProductAttributeDTO[index],
                                                                          val);
                                                                    },
                                                                    dialogBox: true,
                                                                     isExpanded: true,
                                                                    menuConstraints:
                                                                        BoxConstraints.tight(
                                                                            Size.fromHeight(350)),
                                                                  ),
                                                                */
                                                                )
                                                              : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "year"
                                                                  ? Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child: new DropdownButton<
                                                                          String>(
                                                                        items: List<String>.generate(
                                                                            num.parse(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catProdAttrValues[0].value) -
                                                                                num.parse(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catProdAttrValues[0].name),
                                                                            (counter) => (num.parse(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catProdAttrValues[0].name) + counter).toString()).map((String value) {
                                                                          return new DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                new Text(value),
                                                                          );
                                                                        }).toList(),
                                                                        isExpanded:
                                                                            true,
                                                                        onChanged:
                                                                            (year) {
                                                                          print(
                                                                              year);
                                                                          widget
                                                                              .productAttributes
                                                                              .listCatProdAttrLoBRespDTO
                                                                              .createCategoryProductAttributeDTO[index]
                                                                              .productAttributeDetailDTO
                                                                              .value = year;
                                                                          // setProductAttribute(
                                                                          //     widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],
                                                                          //     year);
                                                                        },
                                                                      ),
                                                                    )
                                                                  : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "textarea" || widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "description"
                                                                      ? Container(
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              TextFormField(
                                                                            maxLines:
                                                                                4,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                                                                hintText: widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDTO.name.toString(),
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                            validator:
                                                                                (arg1) {
                                                                              print("validator called...$arg1");
                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.value = arg1;
                                                                              // setProductAttribute(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index], arg1);
                                                                              return null;
                                                                            },
                                                                          ),
                                                                        )
                                                                      : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "file" || widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "certification"
                                                                          ? Container(
                                                                              padding: EdgeInsets.all(10),
                                                                              child: Container(
                                                                                child: IconButton(
                                                                                    icon: Icon(Icons.add),
                                                                                    onPressed: () {
                                                                                      getFilePickers(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index]);
                                                                                    }),
                                                                              ),
                                                                            )
                                                                          : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "Delivery Schedule"
                                                                              ? Container(
                                                                                  padding: EdgeInsets.all(10),
                                                                                  child: Row(
                                                                                    children: <Widget>[
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
                                                                                          isExpanded: true,
                                                                                          onChanged: (period) {
                                                                                            print(period);
                                                                                            widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.selectedPeriod = period;
                                                                                            // saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],val,'Period');
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
                                                                                            widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                            // saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'Start');
                                                                                            return null;
                                                                                          },
                                                                                          onChanged: (start) {
                                                                                            widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.startTime = start;
                                                                                            // saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'Start');
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
                                                                                            widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.endTime = end;
                                                                                            //  saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'End');
                                                                                            return null;
                                                                                          },
                                                                                          onChanged: (end) {
                                                                                            widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.endTime = end;
                                                                                            //  saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'End');
                                                                                            return null;
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ))
                                                                              : widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType == "price"
                                                                                  ? Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                                                                                        Container(
                                                                                          child: Text('Unit of Measurement'),
                                                                                          padding: EdgeInsets.all(10),
                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(10),
                                                                                          child: DropdownButton(
                                                                                            hint: Text('select UOM'),
                                                                                            isExpanded: true,
                                                                                            // value: null,
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
                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType = new UnitType();
                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType.unit = val.unit.toString();
                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.unitType.description = val.description.toString();
                                                                                                  print(jsonEncode(val));
                                                                                                  // this.price.unitType = val.unit.toString();
                                                                                                  // print(this.price.unitType);
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
                                                                                            //  value: price.currency,
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
                                                                                                  // this.price.currency = val.currency;
                                                                                                  print(val);
                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency = val.currency;
                                                                                                  print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.currency);
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
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.perUnitWeight = perUnitWeight;
                                                                                              return null;
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
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.minOrderQty = minOrderQuantity;
                                                                                              return null;
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                        Column(
                                                                                          children: <Widget>[
                                                                                            ListView.builder(
                                                                                               physics: const NeverScrollableScrollPhysics(),
                                                                                                shrinkWrap: true,
                                                                                              itemCount: widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length ,
                                                                                              itemBuilder: (BuildContext context,int index){
                                                                                              return IconButton(icon: Icon(Icons.add), onPressed: (){
                                                                                               
                                                                                                   print(jsonEncode( widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO));
                                                                                                  //  print(jsonEncode( widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price));
                                                                                                  //   print(jsonEncode( widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.length));
                                                                                                  // print(jsonEncode( widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList));
                                                                                                // widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.add(new PriceList() );
                                                                                            
                                                                                              });
                                                                                            })
                                                                                          ],
                                                                                        ),
                                                                                        /* Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: List.generate(1, (index1) {
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price = new Price();
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList = [];
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList.add(new PriceList());
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs = [];
                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs.add(new ProductPriceSlabs());
                                                                                              return Column(
                                                                                                children: List.generate(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs.length, (index2) {
                                                                                                  return Column(
                                                                                                    children: <Widget>[
                                                                                                      Container(
                                                                                                        padding: EdgeInsets.all(10),
                                                                                                        child: Text('Type of Pricing'),
                                                                                                        alignment: Alignment.centerLeft,
                                                                                                      ),
                                                                                                      Container(
                                                                                                        padding: EdgeInsets.all(10),
                                                                                                        child: DropdownButton(
                                                                                                          hint: Text('select Price Type'),
                                                                                                          //  value: price.currency,
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
                                                                                                          onChanged: (IncotermDto val) {
                                                                                                            // this.price.currency = val.currency;
                                                                                                            print(val);
                                                                                                            if (val.incoterm != null) {
                                                                                                              widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].priceType = val.incoterm;
                                                                                                              print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].priceType);
                                                                                                            } else {
                                                                                                              print('value not setted...!');
                                                                                                            }
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        child: Text('Order Price'),
                                                                                                        alignment: Alignment.centerLeft,
                                                                                                        padding: EdgeInsets.all(10),
                                                                                                      ),
                                                                                                      Row(
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
                                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].rangeStart = num.parse(val);
                                                                                                                  print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].rangeStart);
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
                                                                                                                  widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].price = val;
                                                                                                                  print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].price);
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            child: Text('/Centimeter'),
                                                                                                          ),
                                                                                                          Container(
                                                                                                            child: ClipOval(
                                                                                                              child: Material(
                                                                                                                color: Colors.green, // button color
                                                                                                                child: InkWell(
                                                                                                                  splashColor: Colors.lightGreen, // inkwell color
                                                                                                                  child: SizedBox(
                                                                                                                      width: 35,
                                                                                                                      height: 35,
                                                                                                                      child: Icon(
                                                                                                                        Icons.add,
                                                                                                                        color: Colors.white,
                                                                                                                      )),
                                                                                                                  onTap: () {
                                                                                                                    setState(() {
                                                                                                                      print('tapped...!');
                                                                                                                      print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].price);
                                                                                                                      print(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].productPriceSlabs[index2].rangeStart);
                                                                                                                      widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index].productPriceSlabs.add(new ProductPriceSlabs());
                                                                                                                    });
                                                                                                                  },
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                      Container(
                                                                                                        child: Text('Order Delivery Time'),
                                                                                                        alignment: Alignment.centerLeft,
                                                                                                        padding: EdgeInsets.all(10),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: <Widget>[
                                                                                                          Expanded(
                                                                                                            child: new DropdownButton<String>(
                                                                                                              items: ['Days', 'Weeks', 'Months'].map((value) {
                                                                                                                return new DropdownMenuItem<String>(
                                                                                                                  value: value,
                                                                                                                  child: new Text(value),
                                                                                                                );
                                                                                                              }).toList(),
                                                                                                              isExpanded: true,
                                                                                                              onChanged: (period) {
                                                                                                                print(period);
                                                                                                                if (period != null) widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].edcSelectedTime = period;
                                                                                                                //  saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],val,'Period');
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
                                                                                                                widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].edcStart = start;
                                                                                                                // saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'Start');
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
                                                                                                                widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDetailDTO.price.priceList[index1].edcEnd = end;
                                                                                                                //  saveDeliverySchedule(widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index],arg1,'End');
                                                                                                                return null;
                                                                                                              },
                                                                                                              onChanged: (val) {
                                                                                                                print(val);
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    ],
                                                                                                  );
                                                                                                }),
                                                                                              );
                                                                                            })),

 */
                                                                                        /*  Row(
                                                                                          children: <Widget>[
                                                                                            Expanded(
                                                                                              child: Container(
                                                                                                padding: EdgeInsets.all(10),
                                                                                                child: TextFormField(
                                                                                                  decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10), hintText: 'Start', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                                  validator: (arg1) {
                                                                                                    return null;
                                                                                                  },
                                                                                                  onChanged: (String val) {
                                                                                                    this.start = val;
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
                                                                                                    this.end = val;
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
                                                                                                    this.cost = val;
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Text('/Centimeter'),
                                                                                            ),
                                                                                            Container(
                                                                                              child: ClipOval(
                                                                                                child: Material(
                                                                                                  color: Colors.green, // button color
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.lightGreen, // inkwell color
                                                                                                    child: SizedBox(
                                                                                                        width: 35,
                                                                                                        height: 35,
                                                                                                        child: Icon(
                                                                                                          Icons.add,
                                                                                                          color: Colors.white,
                                                                                                        )),
                                                                                                    onTap: () {
                                                                                                      // ProductPriceSlabs productPriceSlabs = new ProductPriceSlabs();
                                                                                                      // productPriceSlabs.rangeStart = this.end;
                                                                                                      // productPriceSlabs.price = this.cost;
                                                                                                      // this.productPriceSlabs.add(productPriceSlabs);
                                                                                                      // this.price.productPriceSlabs = this.productPriceSlabs;
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ), */
                                                                                      ]),
                                                                                    )
                                                                                  : Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      // margin: EdgeInsets.all(10),
                                                                                      child: TextFormField(
                                                                                        decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), hintText: widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].productAttributeDTO.name.toString(), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                                                                        validator: (arg1) {
                                                                                          return null;
                                                                                        },
                                                                                      ))
                            ],
                          );
                        }),
                    /* ListView.builder(
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
                                                              val.unit
                                                                  .toString();
                                                          print(this
                                                              .price
                                                              .unitType);
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
                                                          print(this
                                                              .price
                                                              .currency);
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
                                                        hintText:
                                                            'Per Unit Weight In Kg \'s ',
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
                                                        hintText:
                                                            'Minimum Order Quantity',
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
                                                          onChanged:
                                                              (String val) {
                                                            this.start = val;
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
                                                          onChanged:
                                                              (String val) {
                                                            this.end = val;
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
                                                          onChanged:
                                                              (String val) {
                                                            this.cost = val;
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
                                                              ProductPriceSlabs
                                                                  productPriceSlabs =
                                                                  new ProductPriceSlabs();
                                                              productPriceSlabs
                                                                      .rangeStart =
                                                                  this.end;
                                                              productPriceSlabs
                                                                      .price =
                                                                  this.cost;
                                                              this
                                                                  .productPriceSlabs
                                                                  .add(
                                                                      productPriceSlabs);
                                                              this
                                                                      .price
                                                                      .productPriceSlabs =
                                                                  this.productPriceSlabs;
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
 */
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
