import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/Profile/Profile.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

void main() => runApp(MaterialApp(
      home: Sample(),
      debugShowCheckedModeBanner: false,
    ));

class Sample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),//
      body: ListView(
        children: <Widget>[
          Container(
            height: 600.0,
            child: Products(),
          ),
        ],
      ),
    );
  }
}
