import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
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
                child: new ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Categories'),
                  leading: Icon(Icons.dashboard),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Favourites'),
                  leading: Icon(Icons.favorite),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Orders'),
                  leading: Icon(Icons.shopping_basket),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Notifications'),
                  leading: Icon(Icons.notifications),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                ),
              ),
              InkWell(
                child: new ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.info),
                ),
              )
            ],
          ),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          padding: EdgeInsets.all(8.0),
          // Generate 100 widgets that display their index in the List.
          children: List.generate(20, (index) {
            return Card(
              child: Center(
                child: Text(
                  'Item $index',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                ),
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
        child: Text('chat'),
    backgroundColor: Colors.green,
    ),
    );
  }
}
