import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomToolBar(),
        bottomNavigationBar: CustomNavBar(),
        drawer: CustomDrawer(),
        body: ListView(
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/music/music3.jpeg",
                          height: 150,
                          width: 150,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("Guitar for girls",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Order Id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("20141024",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("Accepted",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/bikes/bulllet.jpeg",
                          height: 150,
                          width: 150,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("Royal Enfield",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Order Id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("10431043",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("Delivered",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/music/music3.jpeg",
                          height: 150,
                          width: 150,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("Guitar for girls",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Order Id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("20141024",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("Accepted",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/bikes/bulllet.jpeg",
                          height: 150,
                          width: 150,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("Royal Enfield",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Order Id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("10431043",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("Delivered",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/music/music5.jpeg",
                          height: 150,
                          width: 150,
                        ),
                        Expanded(
                          child: Container(
                            height: 150,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("Guitar for girls",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Order Id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("20141024",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          width: 150,
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text("Accepted",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
