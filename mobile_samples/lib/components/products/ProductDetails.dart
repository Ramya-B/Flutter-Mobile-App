import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

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
      body: Image.asset('assets/cars/$imageUrl'),
      bottomNavigationBar: CustomNavBar(),
      drawer: CustomDrawer()
    );
  }
}
