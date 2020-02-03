import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

class AlertNotifications extends StatefulWidget {
  @override
  _AlertNotificationsState createState() => _AlertNotificationsState();
}

class _AlertNotificationsState extends State<AlertNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            height: 35,
            child: Text(
              'Notifications',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          Container(
            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.person,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                          'Name of the user has been updated succesfully.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.shopping_basket),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Your order is accepted by the Tradeleaves.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.favorite,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Venkat added your product as favourite.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.message,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('You has received a message from sandeep.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.shopping_basket),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                          'Your order is Shipped by the Tradeleaves.If you want to track your order you can contact Tradeleaves support or else you can see by click here.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.local_grocery_store,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Yamaha R15 is added to cart'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.account_balance,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child:
                          Text('Your Company is approved by the Tradeleaves.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.verified_user,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child:
                          Text('You has subscribed Tradeleaves Bonrze plan.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.person,
                    ),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                          'Name of the user has been updated succesfully.'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Card(
              color: Color.fromRGBO(224, 242, 241, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.shopping_basket),
                    width: 50,
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Your order is accepted by the Tradeleaves.'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
