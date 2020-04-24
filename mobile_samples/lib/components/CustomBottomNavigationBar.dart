import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/cart/cart.dart';
import 'package:tradeleaves/components/chat/chat.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/landing_pages/bliss_home_page.dart';

import 'landing_pages/tl_landing_pages.dart';

class CustomNavBar extends StatefulWidget {
  final selectedIndex;

  CustomNavBar({this.selectedIndex});

  CustomNavBar getSelectedIndex() {
    return this.selectedIndex;
  }

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedIndex;
  var cartItems = [];
  var items;

  getCartItems() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('fav records called..');
    coll = db.collection("products");
    await coll.find({'isCarted': true}).forEach((v) => this.cartItems.add(v));
    setState(() {
      this.items = this.cartItems.length;
    });
    print("cartItems...");
    print(this.cartItems);
    db.close();
  }

  @override
  void initState() {
    getCartItems();
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  void _onItemTapped(int index) {
    print(index);
    switch (index) {
      case 0:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      child:TradeleavesLandingPage(),
                    ),
                    bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                    drawer: CustomDrawer(),
                  )));
        }
        break;
      case 1:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      child: MyCart(),
                    ),
                    bottomNavigationBar: CustomNavBar(
                      selectedIndex: 1,
                    ),
                    drawer: CustomDrawer(),
                  )));
        }
        break;
      case 2:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      child: MyChats(),
                    ),
                    bottomNavigationBar: CustomNavBar(
                      selectedIndex: 2,
                    ),
                    // drawer: CustomDrawer(),
                  )));
        }
        break;
      default:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => TradeleavesLandingPage(),
                    ));
        }
        break;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
          title: new Text('Cart'),
          icon: new Stack(children: <Widget>[
            new Container(
              child:  new Icon(Icons.shopping_cart),
             
            ),
          ]),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green,
      onTap: _onItemTapped,
    );
  }
}
