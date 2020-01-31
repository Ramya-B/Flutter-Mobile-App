import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
var cartItems = [
  {
    'productName' : 'R11 Yamaha',
    'imageUrl' : 'assets/bikes/r11.jpeg',
    'price' : 120000
  },
  {
    'productName' : 'Guitar',
    'imageUrl' : 'assets/music/music3.jpeg',
    'price' : 7800
  },
  {
    'productName' : 'Nike footwear',
    'imageUrl' : 'assets/footwear/footwear3.jpeg',
    'price' : 6000
  },
  {
    'productName' : 'BMW car',
    'imageUrl' : 'assets/cars/pexels-photo-707046.jpeg',
    'price' : 120000
  }
];
  @override
  Widget build(BuildContext context) {
  return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        return new SingleCartItem(
          productName : cartItems[index]['productName'],
          imageUrl :cartItems[index]['imageUrl'],
          price :cartItems[index]['price'],
        );
      }
     );
  }
}

class SingleCartItem extends StatelessWidget {
  final productName;
  final imageUrl;
  final price;
  SingleCartItem(
      {this.productName,
        this.imageUrl,
        this.price,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  child: Image.asset(imageUrl),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:Text(productName,
                        style: TextStyle(fontSize: 18,color:Colors.black87),),
                      ),
                      Container(
                        child: Icon(Icons.remove_circle_outline),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:Text('\$$price',
                          style: TextStyle(fontSize: 18,color:Colors.black87),),
                      ),
                      Container(
                        child: Icon(Icons.favorite ,color:Colors.green),
                      ),
                    ],
                  ),
                )
              ],
          ),
    );
  }
}

