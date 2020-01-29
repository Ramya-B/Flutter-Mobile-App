import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

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
//      child: Image.asset('assets/cars/$imageUrl'),
      appBar: CustomToolBar(),
      body: Image.asset('assets/cars/$imageUrl'),
    );
  }
}
