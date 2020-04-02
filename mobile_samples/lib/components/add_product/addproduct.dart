import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/main.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/productAttributesResp.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import '../../service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;

class AddProduct extends StatefulWidget {
  final ProductAttributesResp productAttributes;
  final ListCatProdAttrLoBDTO categoryRegionLob;
  final List regions;

  AddProduct({this.productAttributes, this.categoryRegionLob, this.regions});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<CreateCategoryProductAttributeDTO> prodValues = [];
  List<ProductAttributeDetailDTO> productAttributeDetailDTOList = [];
  List<ProductLobCountryStatusDTO> productLobCountryStatusDTOList;
  final formKey = new GlobalKey<FormState>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  ProductDTO productDTO = new ProductDTO();
  File file;
  String image;
  List<ImageDTO> imageList;

  @override
  void initState() {
    this.imageList = [];
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
      case "text":
        {
          productAttributeDetailDTO.valueType = "VARCHAR";
        }
        break;
      case "images":
        {
          productAttributeDetailDTO.valueType = "BLOB";
        }
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }
    print("before removing ");
    print(this.productAttributeDetailDTOList);
    for (var item in this.productAttributeDetailDTOList) {
      if (item.attributeName ==
          createCategoryProductAttributeDTO.productAttributeDTO.name) {
        print("removing the ${item.attributeName}");
        this.productAttributeDetailDTOList.remove(item);
      }
    }
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
    print("step3");
    for (var item in widget.categoryRegionLob.lobId) {
      for (var countries in widget.regions) {
        ProductLobCountryStatusDTO productLobCountryStatusDTO =
            ProductLobCountryStatusDTO();
        productLobCountryStatusDTO.productLobCountryStatusId = null;
        productLobCountryStatusDTO.productId = null;
        productLobCountryStatusDTO.lobId = item.toString();
        productLobCountryStatusDTO.regionId = "ASIA";
        productLobCountryStatusDTO.countryId = countries.toString();
        productLobCountryStatusDTO.statusId = "Created";
        productLobCountryStatusDTO.reason = null;
        productDTO.productLobCountryStatusDTO.add(productLobCountryStatusDTO);
      }
    }
    ProductOptionDTO productOptionDTO = ProductOptionDTO();
    productOptionDTO.productOptionName = productDTO.productName;
    productOptionDTO.productAttributeDetailDTO = [];
    productOptionDTO.priceList = [];
    productOptionDTO.deliveryScheduleDTO = [];
    productOptionDTO.imageDTO = this.imageList;
    productOptionDTO.start = "2000-10-22";
    productDTO.productOptionDTO.add(productOptionDTO);
  }

  void _handleSubmitted(String value) {
    print("on submitted called ...!");
    print(value);
  }

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
                              (     widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .catgryProductAttributeDTO
                                          .displayType ==
                                      "text" ||  widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .catgryProductAttributeDTO
                                          .displayType ==
                                      "email"|| widget
                                          .productAttributes
                                          .listCatProdAttrLoBRespDTO
                                          .createCategoryProductAttributeDTO[
                                              index]
                                          .catgryProductAttributeDTO
                                          .displayType ==
                                      "number" ||  widget
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
                                        keyboardType: widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="email" ? 
                                        TextInputType.emailAddress :widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="url"? TextInputType.url :
                                        widget.productAttributes.listCatProdAttrLoBRespDTO.createCategoryProductAttributeDTO[index].catgryProductAttributeDTO.displayType =="number"? TextInputType.number :TextInputType.text,
                                          onFieldSubmitted: _handleSubmitted,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
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
                                                      BorderRadius.circular(
                                                          8))),
                                          validator: (arg1) {
                                            return null;
                                          },
                                          onChanged: (String value) {
                                            print("On chaged called");
                                            print(value);
                                            setState(() {
                                              setProductAttribute(
                                                  widget
                                                      .productAttributes
                                                      .listCatProdAttrLoBRespDTO
                                                      .createCategoryProductAttributeDTO[index],
                                                  value);
                                            });
                                          }),
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
                                                                  // _onAddImageClick(index);
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
                                              padding: EdgeInsets.all(10),
                                              // margin: EdgeInsets.all(10),
                                              child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
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
                                                              BorderRadius.circular(
                                                                  8))),
                                                  validator: (arg1) {
                                                    return null;
                                                  },
                                                  onChanged: (String value) {
                                                    print("On chaged called");
                                                    print(value);
                                                    setState(() {
                                                      setProductAttribute(
                                                          widget
                                                              .productAttributes
                                                              .listCatProdAttrLoBRespDTO
                                                              .createCategoryProductAttributeDTO[index],
                                                          value);
                                                    });
                                                  }),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(10),
                                              // margin: EdgeInsets.all(10),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
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
                                                            BorderRadius
                                                                .circular(8))),
                                                validator: (arg1) {
                                                  return null;
                                                },
                                              ))
                            ],
                          );
                        }),
                    // Container(
                    //   child: Text('${this.productAttributeDetailDTOList}'),
                    // ),
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
