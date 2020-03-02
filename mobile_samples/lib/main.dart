import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(MaterialApp(
      home: Sample(),
      debugShowCheckedModeBanner: false,
    ));
}


class Sample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: ListView(
        children: <Widget>[
          Container(
            height: 590.0,
            // child: Products(category: 'all',),
          ),
        ],
      ),
    );
  }
}
