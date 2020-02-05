import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/ProductsList.dart';

class ProductDetails extends StatefulWidget {
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;
  final category;

  ProductDetails(
      {this.productName,
      this.productDescription,
      this.supplierName,
      this.cost,
      this.imageUrl,
      this.category});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var cost;
  @override
  void initState() {
    this.cost = widget.cost;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            width: 250,
            child: Image.asset(widget.imageUrl),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    )),
                Expanded(
                    child: Container(
                        height: 40,
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.productName,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)))),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Cost',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    )),
                Expanded(
                    child: Container(
                        height: 40,
                        alignment: Alignment.bottomLeft,
                        child: Text('\$$cost',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)))),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    )),
                Expanded(
                    child: Container(
                        height: 40,
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.productDescription,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)))),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: 150,
                    child: Text(
                      'Supplier',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    )),
                Expanded(
                    child: Container(
                        height: 40,
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.supplierName,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)))),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 80,
            padding: EdgeInsets.all(20),
            child: Text(
              'Related Products',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
          Container(
            height: 350,
            child: Products(category: widget.category),
          )
        ],
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
    );
  }
}
