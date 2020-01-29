import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/Profile/Profile.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';

void main() => runApp(MaterialApp(
      home: Sample(),
      debugShowCheckedModeBanner: false,
    ));

class Sample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              child: new UserAccountsDrawerHeader(
                accountName: Text('Manohar Nettem'),
                accountEmail: Text('manohar.nettem@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(child: Icon(Icons.person)
                      ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Profile(
                      userId: 'manohar',
                      companyName:'my dream company',
                      emailId:'manohar.nettem@gmail.com',
                      phoneNo: 7799867839,
                      firstName: 'Manohar',
                      lastName: 'Nettem'
                  ))),


              child: new ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Notifications'),
                leading: Icon(Icons.notifications),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {},
              child: new ListTile(
                title: Text('About'),
                leading: Icon(Icons.info),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),//
      body: ListView(
        children: <Widget>[
          Container(
            height: 600.0,
            child: Products(),
          ),
        ],
      ),
      //  floatingActionButton: FloatingActionButton(
      //    onPressed: () {},
      //    child: Text('chat'),
      //    backgroundColor: Colors.green,
      //  ),
    );
  }
}

//main() async {cls
//  Db db = new Db("mongodb://10.0.2.2:27017/tlapp");
//  ObjectId id;
//  DbCollection coll;
//  await db.open();
//  print('connection open');
//  coll = db.collection("products");
//  print('found...!');
//  coll.findOne();
//  print( await coll.find().toList());
//  await db.close();
//}
