import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'TRADELEAVES'
                ))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search), onPressed: () {}),
          new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      );
  }
}
