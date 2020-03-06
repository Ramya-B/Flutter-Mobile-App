import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/podos/search/search.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

class SearchItems extends StatefulWidget {
  final int categoryId;
  final bool isCategoryBasedSearch;
  SearchItems({this.categoryId,this.isCategoryBasedSearch});
  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  var keyword;
  List prodList = [];
  List res = [];
  String selectedLob;
  String countryId;
  ScrollController _controller;
  var totalProducts;
  var counter = 1;
  var productSearchCriteriaDTODup;
  var pageStart = 0;
  var key;

  searchProducts() async {
    ProductSearchCriteriaDTO productSearchCriteriaDTO =
        new ProductSearchCriteriaDTO();
    Pagination pagination = new Pagination(start: this.pageStart, limit: 10);
    productSearchCriteriaDTO.pagination = pagination;
    productSearchCriteriaDTO.sortBy = "relevance";
    productSearchCriteriaDTO.countryId = "IN";
    productSearchCriteriaDTO.region = "IN";
    productSearchCriteriaDTO.channel = "B2BInternational";
    ProductPrimarySearchCondition productPrimarySearchCondition =
        new ProductPrimarySearchCondition();
    productPrimarySearchCondition.condition = this.keyword;
    productSearchCriteriaDTO.productPrimarySearchCondition =
        productPrimarySearchCondition;
    SiteCriteria siteCriteria = new SiteCriteria();
    siteCriteria.channel = "B2BInternational";
    siteCriteria.site = "1152f6df-91cf-4fc2-afa7-2baa63ef5429";
    siteCriteria.status = "Approved";
    productSearchCriteriaDTO.siteCriteria = siteCriteria;
    print("productSearchCriteriaDTO1");
    print(productSearchCriteriaDTO);

    var data = await catalogService.search(productSearchCriteriaDTO);
    this.totalProducts = data["productDTO"]["totalProducts"];
    this.res = data["productDTO"]["getAllActiveProductsSupplierResponseDTO"];
    print("result is...");
    print(this.res);
    if (this.res.length > 0) {
      setState(() {
        if (this.key != this.keyword) {
          this.prodList = [];
        }
        for (var item = 0; item < this.res.length; item++) {
          print(SearchResults.fromJson(this.res[item]));
          this.counter++;
          this.prodList.add(SearchResults.fromJson(this.res[item]));
        }
        this.key = this.keyword;
      });
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        if (this.totalProducts > this.counter) {
          this.pageStart++;
          print("scrolling is over.so fetching --${this.pageStart}");
          searchProducts();
        }
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("scroll reached the top...!");
      });
    }
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
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => Products(prodList: this.prodList)));
        });
      }
     


  }

  @override
  void initState() {
    if(widget.isCategoryBasedSearch !=null && widget.isCategoryBasedSearch == true && widget.categoryId != null){
      getProductsByCategory(widget.categoryId);
    }
   
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    this.prodList = [];
    print("init calling....searchProducts");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
                    obscureText: false,
                    style: new TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Search...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (String userName) {
                      this.keyword = userName;
                      print(userName);
                    })),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  (this.key != this.keyword) ? searchProducts() : {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 600,
            child: GridView.builder(
                controller: _controller,
                itemCount: this.prodList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return SingleProduct(
                    productDTO: this.prodList[index].productDTO,
                    supplierDTO: this.prodList[index].supplierSearchDTO,
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
