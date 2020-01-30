import 'package:flutter/material.dart';

class UserProfie extends StatefulWidget {
  @override
  _UserProfieState createState() => _UserProfieState();
}

class _UserProfieState extends State<UserProfie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Welcome to Tradeleaves India Private Limited', style: TextStyle(color: Colors.green),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}