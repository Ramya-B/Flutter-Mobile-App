import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/ProductDetails.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var cartItems = [];

  getCartItems() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('fav records called..');
    coll = db.collection("products");
    await coll.find({'isCarted': true}).forEach((v) => cartItems.add(v));
    setState(() {
      this.cartItems = cartItems;
    });
    print("cartItems...");
    print(cartItems);
    db.close();
  }

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return new SingleCartItem(
            id: cartItems[index]['_id'],
            productName: cartItems[index]['productName'],
            productDescription: cartItems[index]['productDescription'],
            supplierName: cartItems[index]['supplierName'],
            cost: cartItems[index]['cost'],
            imageUrl: cartItems[index]['imageUrl'],
            isFavourited: cartItems[index]['isFavourited'],
            isCarted: cartItems[index]['isCarted'],
            isOrdered: cartItems[index]['isOrdered'],
            category: cartItems[index]['category'],
          );
        });
  }
}

class SingleCartItem extends StatefulWidget {
  final id;
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;
  final isFavourited;
  final isCarted;
  final isOrdered;
  final category;

  SingleCartItem(
      {this.id,
      this.productName,
      this.productDescription,
      this.imageUrl,
      this.cost,
      this.supplierName,
      this.isFavourited,
      this.isCarted,
      this.isOrdered,
      this.category});

  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  bool isFavourited;
  bool isOrdered;
  bool isCarted;
  String cost;

  void initState() {
    this.isFavourited = widget.isFavourited;
    this.isOrdered = widget.isOrdered;
    this.isCarted = widget.isCarted;
    this.cost = widget.cost.toString();
    super.initState();
  }

  void save(type, value) async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('save called');
    print(this.isCarted);
    coll = db.collection("products");
    if (type != null) {
      var res = await coll.findOne({'_id': widget.id});
      if (type == 'favourite') {
        res["isFavourited"] = value;
      } else if (type == 'cart') {
        res["isCarted"] = value;
      } else if (type == 'order') {
        res["isOrdered"] = value;
      }
      await coll.save(res);
    }
    db.close();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new ProductDetails(
              productName: widget.productName,
              productDescription: widget.productDescription,
              supplierName: widget.supplierName,
              cost: widget.cost,
              imageUrl: widget.imageUrl,
              category: widget.category))),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              alignment: Alignment.center,
              child: Image.asset(widget.imageUrl),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.productName,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(
                          (this.isCarted)
                              ? Icons.remove_shopping_cart
                              : Icons.add_shopping_cart,
                          color:
                              (this.isCarted) ? Colors.green : Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            this.isCarted = !this.isCarted;
                            save('favourite', this.isCarted);
                          });
                        }),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '\$$cost',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(
                          (this.isFavourited)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (this.isFavourited)
                              ? Colors.green
                              : Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            this.isFavourited = !this.isFavourited;
                            save('favourite', this.isFavourited);
                          });
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
