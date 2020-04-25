import 'package:flutter/material.dart';
import 'package:tradeleaves/components/contact_supplier/contact_supplier.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';
import 'package:tradeleaves/models/index.dart';
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
    Pagination pagination = new Pagination();
    pagination.start = 0;
    pagination.limit= 10;
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
    return Column(
      children: <Widget>[
         (this.promotedProducts.length > 0 && (widget.promoType=='TopList' ||widget.promoType=='SponsoredAds' )) ? Container(
          child: Text(
            (widget.promoType=='TopList') ?'Highlights': (widget.promoType=='SponsoredAds') ?'Sponsored Ads':'',
            style: TextStyle(fontSize: 18),
          ),
          padding: EdgeInsets.all(10),
          alignment: Alignment.topLeft,
        ):Container(),
         Container(
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
                isSearchResults: true,
              );
            })),
      ],
    );
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
            isSearchResults: true,
          );
        });
  }
}

class SingleProduct extends StatefulWidget {
  final ProductDTO productDTO;
  final SupplierDTO supplierDTO;
  final bool isSearchResults;

  SingleProduct({
    this.productDTO,
    this.supplierDTO,
    this.isSearchResults
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  bool isFavorited = false;

  handleFav() async{
    setState(() {
      widget.productDTO.isFavorited = !widget.productDTO.isFavorited;
    });
    FavouriteProductsDTO favouriteProductsDTO = new FavouriteProductsDTO();
    favouriteProductsDTO.productId = widget.productDTO.productId;
    favouriteProductsDTO.productImageUrl = widget.productDTO.primaryImageUrl;
    favouriteProductsDTO.suppplierName = widget.supplierDTO.supplierName;
    favouriteProductsDTO.partyId = widget.supplierDTO.supplierId;
    catalogService.handleFavorites(favouriteProductsDTO);
  }
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
              (widget.productDTO.primaryImageUrl != null )? Image.network(
                (widget.productDTO.primaryImageUrl.toString().contains('http') )? ('${widget.productDTO.primaryImageUrl}'):('${Constants.envUrl}${Constants.mongoImageUrl}/${widget.productDTO.primaryImageUrl}'),
                width: 120,
                height: 120,
              ):Container( width: 120,
                height: 120,
                child: Icon(Icons.image)),
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
              Expanded( child: Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Expanded(child: IconButton(icon: Icon(widget.productDTO.isFavorited ? Icons.favorite : Icons.favorite_border),color:Colors.green, onPressed: (){
                       handleFav();
                      })),
                      Expanded(child: IconButton(icon: Icon(Icons.message), color: Colors.green,onPressed: (){
                          if(widget.isSearchResults){
                             Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => new ContactSupplier(
                                productDTO: widget.productDTO,
                                supplierDTO: widget.supplierDTO,
                              )));
                          }
                          
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
