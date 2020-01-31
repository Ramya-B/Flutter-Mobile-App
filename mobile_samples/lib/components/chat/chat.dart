import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyChats extends StatefulWidget {
  @override
  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  var output = [
    {'message': 'Hi..!', 'input': 'true'},
    {'message': 'Hi..!', 'input': 'false'},
    {'message': 'How are you..!', 'input': 'true'},
    {'message': 'I am fine..!', 'input': 'false'},
  ];
  var input = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: Text(
              'hello.....',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  width: 350,
                  height: 400,
                  child: TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "message",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    width: 30,
                    height: 400,
                    padding: EdgeInsets.all(10),
                    child:
                        IconButton(icon: Icon(Icons.message), onPressed: () {}))
              ],
            ),
          )
        ],
      ),
    );
  }
}
