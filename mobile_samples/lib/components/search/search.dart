import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/podos/search/search.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

class SearchItems extends StatefulWidget {
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

  searchProducts() async {
    ProductSearchCriteriaDTO productSearchCriteriaDTO =
        new ProductSearchCriteriaDTO();
    Pagination pagination = new Pagination(start: 0, limit: 10);
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
    this.res = await catalogService.search(productSearchCriteriaDTO);
    print("result is...");
    print(this.res);
    if (this.res.length > 0) {
      setState(() {
        this.prodList = [];
        for (var item = 0; item < this.res.length; item++) {
          this.prodList.add(SearchResults.fromJson(this.res[item]));
        }
      });
    }
  }

  @override
  void initState() {
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
              icon: Icon(Icons.search), onPressed: () => searchProducts()),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: GridView.builder(
                itemCount: this.prodList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return SingleProduct(
                    id: this.prodList[index].productDTO.productId,
                    productName: this.prodList[index].productDTO.productName,
                    productDescription: null,
                    supplierName:
                        this.prodList[index].supplierSearchDTO.supplierName,
                    cost: null,
                    imageUrl:
                        'http://uat.tradeleaves.internal/tl/public/assest/get/${this.prodList[index].productDTO.primaryImageUrl}',
                    isFavourited: false,
                    isCarted: false,
                    isOrdered: false,
                    category: this.prodList[index].productDTO.categoryId,
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
