import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/login_register/login.dart';


class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {

  void clearInfo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      print("set state called in logout");
      preferences.clear();
    });
  }
  @override
  void initState() {
    print("init called in logout");
    clearInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Login();
  }
}

