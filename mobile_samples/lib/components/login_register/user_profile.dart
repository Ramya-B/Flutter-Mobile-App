import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class UserProfie extends StatefulWidget {
  @override
  _UserProfieState createState() => _UserProfieState();
}

class _UserProfieState extends State<UserProfie> {
  String welcomeMessage = "Welome Mr. Venkat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomToolBar(),
        body: Center(
          child: Container(
            child: Center(
              child: SizedBox(
                width: 150, 
                height: 150, 
                child: Image.asset('assets/tl.png')
              ),
            )
          ),
        ));
  }
}
