import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';

class ProductDetails extends StatelessWidget {
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;

  ProductDetails(
      {this.productName,
      this.productDescription,
      this.supplierName,
      this.cost,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('$imageUrl'),
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
                          child: Text(productName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black)))),
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
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black)))),
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
                          child: Text(productDescription,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black)))),
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
                          child: Text(supplierName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black)))),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
    );
  }
}
