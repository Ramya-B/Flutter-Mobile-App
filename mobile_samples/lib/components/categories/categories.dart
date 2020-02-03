import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar() ,
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body: Container(
        height: 500.0,
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            InkWell(
              onTap: (){},
              child: Card(
                  child:Column(
                    children: <Widget>[
                      Image.asset('assets/categories/music.png',  height: 130,
                        width: 130,),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Music',
                            style: TextStyle(fontSize: 20,color: Colors.black45),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
            InkWell(
              child: Card(
                  child:Column(
                    children: <Widget>[
                      Image.asset('assets/categories/cars.png',  height: 130,
                        width: 130,),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Cars',
                            style: TextStyle(fontSize: 20,color: Colors.black45),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
            InkWell(
              onTap: (){},
              child: Card(
                  child:Column(
                    children: <Widget>[
                      Image.asset('assets/categories/bikes.png',  height: 130,
                        width: 130,),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Bikes',
                            style: TextStyle(fontSize: 20,color: Colors.black45),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
            InkWell(
              child: Card(
                  child:Column(
                    children: <Widget>[
                      Image.asset('assets/categories/footwear.png',  height: 130,
                        width: 130,),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Footwear',
                            style: TextStyle(fontSize: 20,color: Colors.black45),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),


          ],
        ),
      ),
    );
  }
}
