import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/cart/cart.dart';
import 'package:tradeleaves/components/chat/chat.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class CustomNavBar extends StatefulWidget {
  final selectedIndex ;
  CustomNavBar({this.selectedIndex});
  CustomNavBar getSelectedIndex(){
    return this.selectedIndex;
  }
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedIndex;
  @override
  // ignore: must_call_super
  initState() {
    selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    print(index);
    switch (index) {
      case 0:
        {
          if(selectedIndex != index){
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new Scaffold(
                  appBar: CustomToolBar(),
                  body: Container(
                    child: Products(category: 'all') ,
                  ),
                  bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                  drawer: CustomDrawer(),
                )));
          }
        }
        break;
      case 1:
        {
          if(selectedIndex != index){
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
        }
        break;
      case 2:
        {
          if(selectedIndex != index){
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
        }
        break;
      default:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Scaffold(
                appBar: CustomToolBar(),
                body: Container(
                  child: Products(category: 'all') ,
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
            icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}