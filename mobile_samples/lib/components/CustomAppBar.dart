import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/login_register/login_page.dart';

class CustomToolBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('TRADELEAVES'),
              ))
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: <Widget>[
        new IconButton(icon: Icon(Icons.search), onPressed: () {}),
        new IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new UserLogin())))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55.0);
}
