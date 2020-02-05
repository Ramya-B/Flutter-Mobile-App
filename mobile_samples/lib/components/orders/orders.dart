import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/ProductDetails.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var orderList = [];

  getOrders() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('fav records called..');
    coll = db.collection("products");
    await coll.find({'isOrdered': true}).forEach((v) => orderList.add(v));
    setState(() {
      this.orderList = orderList;
    });
    print("ordered records...");
    print(orderList);
    db.close();
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomToolBar(),
        bottomNavigationBar: CustomNavBar(selectedIndex: 0),
        drawer: CustomDrawer(),
        body: ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleOrder(
                id: orderList[index]['_id'],
                productName: orderList[index]['productName'],
                productDescription: orderList[index]['productDescription'],
                supplierName: orderList[index]['supplierName'],
                cost: orderList[index]['cost'],
                imageUrl: orderList[index]['imageUrl'],
                isFavourited: orderList[index]['isFavourited'],
                isCarted: orderList[index]['isCarted'],
                isOrdered: orderList[index]['isOrdered'],
                category: orderList[index]['category'],
              );
            }));
  }
}

class SingleOrder extends StatefulWidget {
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

  SingleOrder(
      {this.id,
      this.productName,
      this.productDescription,
      this.supplierName,
      this.cost,
      this.isFavourited,
      this.isCarted,
      this.isOrdered,
      this.imageUrl,
      this.category});

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
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
      child: Container(
        alignment: Alignment.topCenter,
        child: Card(
          child: Row(
            children: <Widget>[
              Image.asset(
                widget.imageUrl,
                height: 130,
                width: 150,
              ),
              Expanded(
                child: Container(
                  height: 150,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(widget.productName,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomLeft,
                                width: 70,
                                child: Text(
                                  'Order Id',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      widget.id.toString().substring(10, 25),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomLeft,
                                width: 70,
                                child: Text(
                                  'Supplier',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(widget.supplierName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ))
                            ],
                          ),
                        ),
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
