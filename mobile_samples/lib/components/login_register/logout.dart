import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //Remove String
      prefs.remove("fullName");
      //Remove bool
      prefs.remove("emailId");
    });
  }

  @override
  void initState() {
    removeValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomToolBar(),
      bottomNavigationBar: CustomNavBar(),
      drawer: CustomDrawer(),
      body: Container(
        child: Products(),
      ),

    );
  }
}
