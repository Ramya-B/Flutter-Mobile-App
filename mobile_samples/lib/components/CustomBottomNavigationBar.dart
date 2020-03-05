import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/cart/cart.dart';
import 'package:tradeleaves/components/chat/chat.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

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
                      // child: Products(category: 'all'),
                      child: FetchPromotedProducts(),
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
                    drawer: CustomDrawer(),
                  )));
        }
        break;
      default:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      // child: Products(category: 'all'),
                    ),
                    bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                    drawer: CustomDrawer(),
                  )));
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
//            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
          title: new Text('Cart'),
          icon: new Stack(children: <Widget>[
            new Container(
              child:  new Icon(Icons.shopping_cart),
             
            ),
//             new Positioned(
//               // draw a red marble
//               top: 0.0,
//               right: 0.0,
//               child: new Container(
// //                padding: EdgeInsets.all(2),
//                 decoration: new BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 constraints: BoxConstraints(
//                   minWidth: 14,
//                   minHeight: 14,
//                 ),
//                 child: Text(
//                   this.items.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             )
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
