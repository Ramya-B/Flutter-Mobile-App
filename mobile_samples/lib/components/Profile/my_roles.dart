import 'package:flutter/material.dart';

class MyRoles extends StatefulWidget {
  @override
  _MyRolesState createState() => _MyRolesState();
}

class _MyRolesState extends State<MyRoles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MyRoles Page'),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My Role(s)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'View your allotted roles and permissions, operation you can perform for your company.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
