import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/search/search.dart';
import 'login_register/login.dart';


class CustomToolBar extends StatefulWidget  with PreferredSizeWidget  {
  @override
  _CustomToolBarState createState() => _CustomToolBarState();

 @override
   Size get preferredSize => const Size.fromHeight(55.0);
}

class _CustomToolBarState extends State<CustomToolBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        width: 50,
        child: Row(
        children: <Widget>[
           Expanded(
             child:  new IconButton(icon: Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
           ),
            Expanded(
             child:   new IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop())
           )
          
        ],
      ),
      ),
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
              child: Container(
                alignment: Alignment.center,
                child: Text('TRADELEAVES'),
              ))
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: <Widget>[
        new IconButton(icon: Icon(Icons.search), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SearchItems()))),
       new IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Login())))
      ],
    );
  }
}