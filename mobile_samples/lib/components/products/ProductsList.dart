import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection, where;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';


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
    // TODO: implement initState
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
              Image.asset(
                widget.imageUrl,
                height: 100,
                width: 150,
              ),
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
