import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';

class CategoryProducts extends StatefulWidget {
  final categoryName ;
  final categoryImage;
  CategoryProducts({this.categoryName,this.categoryImage});
  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body:  Container(
        height: 600.0,
        // child: Products(category:widget.categoryName),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0,),
      drawer: CustomDrawer(),
    );
  }
}

