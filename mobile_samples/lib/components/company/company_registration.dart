import 'package:flutter/material.dart';
import 'package:tradeleaves/components/company/person_profile.dart';
import 'package:tradeleaves/components/products/products_home.dart';

import '../CustomAppBar.dart';
import '../CustomBottomNavigationBar.dart';
import '../CustomDrawer.dart';

class CompanyRegistration extends StatefulWidget {
  @override
  _CompanyRegistrationState createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Business Setup'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(25),
          children: <Widget>[
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 200,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Find business',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        'Discover new companies and trading partners to help grow your business. Explore the marketplace and browse by product or industry.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )),
                    ),
                    Center(
                        child: Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      child:HomeProducts(),
                    ),
                    bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                    drawer: CustomDrawer(),
                  ))),
                        child: Text(
                          'Explore Marketplace',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.lightGreen,
                        padding: EdgeInsets.only(left: 30, right: 30),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 200,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Manage your business',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        'Review your profile information and preferences to customize your TradeLeaves experience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )),
                    ),
                    Center(
                        child: Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.green, width: 2)),
                        onPressed: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => PersonalProfile())),
                        child: Text(
                          'Setup Profile',
                          style: TextStyle(color: Colors.green),
                        ),
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 30, right: 30),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 200,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Become a member',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        "Choose a membershipship plan that's right for you. Join our community of verified traders and business partners.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )),
                    ),
                    Center(
                        child: Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.green, width: 2)),
                        onPressed: () {},
                        child: Text(
                          'Explore Subscription',
                          style: TextStyle(color: Colors.green),
                        ),
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 30, right: 30),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 200,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Start trading',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        'Join our community of verified business to start selling on TradeLeaves.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )),
                    ),
                    Center(
                        child: Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.green, width: 2)),
                        onPressed: () {},
                        child: Text(
                          'Register Your Business',
                          style: TextStyle(color: Colors.green),
                        ),
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 30, right: 30),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
