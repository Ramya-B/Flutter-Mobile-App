import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: ListView(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/cars/pexels-photo-707046.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                 child: Container(
                   padding: EdgeInsets.all(10.0),
                   height: 100,
                     child:Row(
                       children: <Widget>[
                         Expanded(child: Container(child: Text('Porshe Car',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                         Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                       ],
                    ),
                 ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/bikes/bulllet.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    child:Row(
                      children: <Widget>[
                        Expanded(child: Container(child: Text('Royal Enfield 350 cc',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                        Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/music/music3.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    child:Row(
                      children: <Widget>[
                        Expanded(child: Container(child: Text('Guitar',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                        Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/bikes/suzuki.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    child:Row(
                      children: <Widget>[
                        Expanded(child: Container(child: Text('Suzuki Sports Bike',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                        Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/footwear/footwear5.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    child:Row(
                      children: <Widget>[
                        Expanded(child: Container(child: Text('Nike Sheos',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                        Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/music/music5.jpeg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 100,
                    child:Row(
                      children: <Widget>[
                        Expanded(child: Container(child: Text('Guitar Stylish',style: TextStyle(fontSize: 18,color: Colors.black87) ),alignment: Alignment.topLeft)),
                        Container(child: Icon(Icons.favorite, color: Colors.green,),alignment: Alignment.center)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}
