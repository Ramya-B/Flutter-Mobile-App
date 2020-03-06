import 'package:flutter/material.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';
import 'package:tradeleaves/podos/search/search.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/service_locator.dart';

import '../../constants.dart';

class FetchPromotedProducts extends StatefulWidget {
  final String promoType;
  FetchPromotedProducts({this.promoType});
  @override
  _FetchPromotedProductsState createState() => _FetchPromotedProductsState();
}

class _FetchPromotedProductsState extends State<FetchPromotedProducts> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  var promotedProducts = [];
  List res = [];
  getPromotedProducts() async {
    PromoProductCriteria promoProductCriteria = new PromoProductCriteria();
    Pagination pagination = new Pagination(start: 0, limit: 10);
    promoProductCriteria.pagination = pagination;
    SiteCriteria siteCriteria = new SiteCriteria();
    siteCriteria.channel = "B2BInternational";
    siteCriteria.region = "IN";
    promoProductCriteria.siteCriteria = siteCriteria;
    // CategoryCriteria categoryCriteria = new CategoryCriteria();
    // categoryCriteria.categoryId = [];
    // promoProductCriteria.categoryCriteria= categoryCriteria;
    promoProductCriteria.promotionID = widget.promoType;
    print("PromoProductCriteria");
    print(promoProductCriteria.toJson());

    this.res = await catalogService.getPromotedProducts(promoProductCriteria);
    print("result of promoted products are..");
    print(this.res);
    if (this.res.length > 0) {
      setState(() {
        this.promotedProducts = [];
        for (var item = 0; item < this.res.length; item++) {
          this.promotedProducts.add(SearchResults.fromJson(this.res[item]));
        }
      });
    }
  }

  @override
  void initState() {
    this.promotedProducts = [];
    print("init calling....searchProducts");
    getPromotedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.promotedProducts.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              return SingleProduct(
                productDTO: this.promotedProducts[index].productDTO,
                supplierDTO: this.promotedProducts[index].supplierSearchDTO,
              );
            }));
  }
}

class Products extends StatefulWidget {
  final List<SearchResults> prodList;
  Products({this.prodList});
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<SearchResults> products;
  var promotedProducts = [];
  List res = [];
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  @override
  void initState() {
     this.promotedProducts = [];
    if (widget.prodList.length > 0) {
      this.promotedProducts = widget.prodList;
    } else {
      this.promotedProducts = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: this.promotedProducts.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productDTO: this.promotedProducts[index].productDTO,
            supplierDTO: this.promotedProducts[index].supplierSearchDTO,
          );
        });
  }
}

class SingleProduct extends StatefulWidget {
  final productDTO;
  final supplierDTO;

  SingleProduct({
    this.productDTO,
    this.supplierDTO,
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ProductDetails(
                  productDTO: widget.productDTO,
                  supplierDTO: widget.supplierDTO,
                ))),
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Image.network(
                (widget.productDTO.primaryImageUrl.toString().contains('http') )? ('${widget.productDTO.primaryImageUrl}'):('${Constants.envUrl}${Constants.mongoImageUrl}${widget.productDTO.primaryImageUrl}'),
                width: 150,
                height: 150,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      widget.productDTO.productName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryProducts{
  
}