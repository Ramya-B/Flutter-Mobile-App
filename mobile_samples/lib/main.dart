import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

void main() => runApp(MaterialApp(
      home: Sample(),
      debugShowCheckedModeBanner: false,
    ));

class Sample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset(
                'assets/tl.png',
                fit: BoxFit.contain,
                height: 25,
              ),
              backgroundColor: Colors.white,
              radius: 15,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('TRADELEAVES'))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search), onPressed: () {}),
          new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              child: new UserAccountsDrawerHeader(
                accountName: Text('Manohar Nettem'),
                accountEmail: Text('manohar.nettem@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(child: Icon(Icons.person)
//                   Image(image: AssetImage('assets/manohar.jpg')) ,
                      ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Notifications'),
                leading: Icon(Icons.notifications),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(
                title: Text('About'),
                leading: Icon(Icons.info),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('New')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),

        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 600.0,
            child: Products(),
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        child: Text('chat'),
//        backgroundColor: Colors.green,
//      ),
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
