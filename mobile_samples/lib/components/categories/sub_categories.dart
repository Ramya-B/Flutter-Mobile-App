import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/search/search.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/podos/search/search.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/podos/products/product.dart';
import '../../service_locator.dart';

class SubCategoryDeatils extends StatefulWidget {
  final CategoryDTO categoryDTO;
  final categoryImage;

  SubCategoryDeatils({Key key, this.categoryDTO, this.categoryImage})
      : super(key: key);

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategoryDeatils> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  var response = [];
  List<CategoryDetailsDTO> categoryDetails = [];
  List subCategoriesList = [];
  String categoryImage;
  List res;
  List<SearchResults> prodList;
  getCategoryDetailsByLoB() async {
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.categoryId = widget.categoryDTO.id.toString();
    categoryDetailsLobDTO.lobId = ["34343e34-7601-40de-878d-01b3bd1f0641"];
    categoryDetailsLobDTO.systemRootCategoryFlag = false;
    print("getCategoryDetailsByLoB request object {}...........");
    print(categoryDetailsLobDTO.toJson());
    var response =
        await catalogService.getCategoryDetailsByLoB(categoryDetailsLobDTO);
    print("getCategoryDetailsByLoB response object {}...........");
    print(response);
    setState(() {
      for (var item = 0; item < response.length; item++) {
        this.categoryDetails.add(CategoryDetailsDTO.fromJson(response[item]));
      }
    });
  }

  getProductsByCategory(int categoryId) async {
      ProductInfo productInfo =  new ProductInfo();
      productInfo.categoryId = categoryId.toString();
      productInfo.isService = false;
      productInfo.countryId = 'IN';
      productInfo.channel = "B2BInternational";
      productInfo.region = "IN";
      productInfo.lobSelection = null;
      productInfo.location = null;
      Filters filters = new Filters();
      filters.tlcriteriaWeights = [];
      filters.suppliertlcriteriaWeights = [];
      filters.sortBy = "relevance";
      Pagination pagination = new Pagination(start: 0,limit: 10);
      filters.pagination = pagination;
      productInfo.countryId = 'IN';
      productInfo.filters = filters;
      print("category products req....");
      print(productInfo.toJson());
      this.prodList = [];
       var data =  await catalogService.getProductsByCategoryId(productInfo);
       print(data);
     var results = data["activeProduct"]["getAllActiveProductsSupplierResponseDTO"];
      print("result is...");
      print(results);
      if (results.length > 0) {
        setState(() {
          for (var item = 0; item < results.length; item++) {
            print(results[item]);
            print(SearchResults.fromJson(results[item]));
            // this.prodList.add(results[item]);
                 this.prodList.add(SearchResults.fromJson(results[item]));
           
           
          }
             Navigator.push(context, MaterialPageRoute(builder: (context) => Products(prodList: this.prodList)));
        });
      }
     


  }

  @override
  void initState() {
    List<SearchResults> prodList = [];
    print("Before Calling getCategoryDetailsByLoB.................");
    getCategoryDetailsByLoB();
    print("After Calling getCategoryDetailsByLoB.................");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              constraints: new BoxConstraints.expand(
                height: 200.0,
              ),
              alignment: Alignment.center,
              padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage("${widget.categoryImage}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Text(
                '${widget.categoryDTO.name}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Text(
                'Import your agriculture & food products with ease and certainty, today.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                  width: 300,
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => new Register()))
                    },
                    elevation: 5,
                    color: Colors.green[900],
                    textColor: Colors.white,
                    splashColor: Colors.green,
                    child: Text(
                      "Sign Me Up For Free Today",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              constraints: new BoxConstraints(
                minHeight: 200.0,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: this.categoryDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                       InkWell(
                        onTap: (){print("tapped");Navigator.push(context, MaterialPageRoute(builder: (context) => SearchItems(categoryId: this.categoryDetails[index].categoryAndAttributesDTO.categoryDTO.id, isCategoryBasedSearch: true,)));}, 
                         child:  Container(
                          color: Colors.green,
                          height: 50,
                          child: Center(
                              child: Text(
                                  '${this.categoryDetails[index].categoryAndAttributesDTO.categoryDTO.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ),
                       ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: this
                                  .categoryDetails[index]
                                  .subCategoryAndAttributesDTO
                                  .length,
                              itemBuilder: (context, int index2) {
                                return Column(
                                  children: <Widget>[
                                    Center(
                                        child: Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${widget.categoryImage}'),
                                              ),
                                            ))),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      // heightFactor: 100,
                                      child: Text(
                                        '${this.categoryDetails[index].subCategoryAndAttributesDTO[index2].categoryDTO.name}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey[600],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
