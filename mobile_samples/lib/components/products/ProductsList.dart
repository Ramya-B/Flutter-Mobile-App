import 'package:flutter/material.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';
import 'package:tradeleaves/podos/search/search.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/service_locator.dart';

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
    SiteCriteria siteCriteria =  new SiteCriteria();
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
      // width: 400,
      height: 200,
     child: GridView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: this.promotedProducts.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productDTO: this.promotedProducts[index].productDTO,
            supplierDTO: this.promotedProducts[index].supplierSearchDTO,
          );
        })
    );
  }
  
  // Widget build(BuildContext context) {
  //   return Container(
  //      constraints: BoxConstraints(minHeight: 650),
  //      height: 600,
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           padding: EdgeInsets.all(10),
  //           alignment: Alignment.topLeft,
  //           child: Text('Promoted Ads',style: TextStyle(fontSize: 20),),
  //         ),
  //         Container(
  //            padding: EdgeInsets.all(10),
  //           child: Products(prodList: [],),
  //           height: 300,
  //         )
  //       ],
  //     ),
  //   );
  // }
}


/*
class Products extends StatefulWidget {
  final String category;

  Products({
    this.category,
  });

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var prodList = [];
  ScrollController _controller;
  var message;
  var length =12;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {if(this.length < 23){
         this.length =this.length+4;
       
        message = "reach the bottom";
        print(message);
         if(widget.category == 'all'){
           print("calling get Records again...");
          getProdRecords();
        }
      }
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
        print(message);
      });
    }
  }
  getProdRecords() async {
    // Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('connection open mongo latest' + widget.category);
    coll = db.collection("products");
   var  prods = [];
   if (widget.category != null && widget.category == 'all') {
      await coll.find(where.limit(this.length)
      ).forEach( (v) =>prods.add(v));



    } else if (widget.category != null) {
      await coll
          .find(where.match('category' , widget.category)).forEach(
              (v) =>
              prods.add(
                  v));
    } else {
      print(
          "category is undefined mr.....!");
    }
    setState(() {
      this.prodList = prods;
    });
    print("after getting all records...");
    print(prodList);
    db.close();
  }
  void setData() async{
      print("set data called in product list...!");
       SharedPreferences sample =  await SharedPreferences.getInstance();
       print(sample.getString('emailId'));
       print(sample.getString('fullName')); 
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getProdRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: this.prodList.length,
        controller: _controller,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            id:prodList[index]['_id'],
            productName: prodList[index]['productName'],
            productDescription: prodList[index]['productDescription'],
            supplierName: prodList[index]['supplierName'],
            cost: prodList[index]['cost'],
            imageUrl: prodList[index]['imageUrl'],
            isFavourited: prodList[index]['isFavourited'],
            isCarted: prodList[index]['isCarted'],
            isOrdered: prodList[index]['isOrdered'],
            category: prodList[index]['category'],
          );
        });
  }
}

class SingleProduct extends StatefulWidget {
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;
  final isFavourited;
  final isCarted;
  final isOrdered;
  final id;
  final category;

  SingleProduct({
    this.productName,
    this.productDescription,
    this.supplierName,
    this.cost,
    this.imageUrl,
    this.isFavourited,
    this.isCarted,
    this.isOrdered,
    this.id,
    this.category
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool isFavourited;
  bool isOrdered;
  bool isCarted;
  @override
  void initState() {
   this.isFavourited = widget.isFavourited;
   this.isOrdered = widget.isOrdered;
   this.isCarted = widget.isCarted;
    super.initState();
  }

   void save(type,value) async{
       Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
       DbCollection coll;
       await db.open();
       print('save called');
       coll = db.collection("products");
      if(type != null){
        var res = await coll.findOne({'_id': widget.id});
        if(type == 'favourite'){
          res["isFavourited"] = value;
        }else  if(type == 'cart'){
          res["isCarted"] = value;
        }else  if(type == 'order'){
          res["isOrdered"] = value;
        }
        await coll.save(res);
      }
       db.close();
   }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ProductDetails(
                  productName: widget.productName,
                  productDescription: widget.productDescription,
                  supplierName: widget.supplierName,
                  cost: widget.cost,
                  imageUrl: widget.imageUrl,
                category:widget.category
                ))),
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Image.network(widget.imageUrl,width: 150,height: 100,) ,
              Expanded(
                  child: Text(
                widget.productName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              )),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
//                    color: Colors.greenAccent
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                            icon: (this.isCarted)
                                ? Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.blueGrey,
                                  ),
                            onPressed: () {
                              setState(() {
                                if (this.isCarted == true) {
                                  this.isCarted = false;
                                } else {
                                  this.isCarted = true;
                                }
                                save('cart',this.isCarted);
                              });
                            }),
                      ),
                      Expanded(
                          child: IconButton(
                              icon: Icon(
                                Icons.shopping_basket,
                                color: (this.isOrdered)
                                    ? Colors.green
                                    : Colors.blueGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (this.isOrdered == true) {
                                    this.isOrdered = false;
                                  } else {
                                    this.isOrdered = true;
                                  }
                                  save('order',this.isOrdered);
                                });
                              })),
                      Expanded(
                          child: IconButton(
                              icon: Icon(
                                (this.isFavourited) ? Icons.favorite :Icons.favorite_border,
                                color: (this.isFavourited)
                                    ? Colors.green
                                    : Colors.blueGrey,
                              ),
                              onPressed: () {

                                setState(() {
                                  if (this.isFavourited == true) {
                                    this.isFavourited = false;
                                  } else {
                                    this.isFavourited = true;
                                  }
                                  save('favourite',this.isFavourited);
                                });
                              })),
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
*/

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
    if(widget.prodList.length > 0){
     this.promotedProducts = widget.prodList;
    }else{
      this.promotedProducts=[];
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
                'http://uat.tradeleaves.internal/tl/public/assest/get/${widget.productDTO.primaryImageUrl}',
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
