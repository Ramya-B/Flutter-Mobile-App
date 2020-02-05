import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/login_register/register_page.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:client_cookie/client_cookie.dart';
import 'package:http/http.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String emailId;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/tl.png'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                    onChanged:  (String userName) {
                      this.emailId = userName;
                      print("user name is " + this.emailId);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                    onChanged: (String password) {
                      this.password = password;
                      print("password is " + this.password);
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                        onPressed: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => new CheckLogIn(
                                  emailId: this.emailId,
                                      passWord: this.password,
                                    ))),
                        textColor: Colors.white,
                        color: Colors.green,
                        height: 45,
                        child: Text("LOGIN")),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                        onPressed: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => new RegistrationPage())),
                        textColor: Colors.white,
                        color: Colors.green,
                        height: 45,
                        child: Text("SIGN UP")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
    );
  }
}

class CheckLogIn extends StatefulWidget {
  final String emailId;
  final String passWord;

  CheckLogIn({this.emailId, this.passWord});

  @override
  _CheckLogInState createState() => _CheckLogInState();
}

class _CheckLogInState extends State<CheckLogIn> {
  var usersStatus = [];

  checkUser() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    coll = db.collection("users");
    print('userName is ');
    print(widget.emailId);
    print('passsword is ');
    print(widget.passWord);
    if (widget.emailId != null && widget.passWord != null) {
      await coll.find({
        'emailId': widget.emailId,
        'password': widget.passWord
      }).forEach((v) => usersStatus.add(v));
    } else {
      print("category is undefined mr.....!");
    }
    setState(() {
      this.usersStatus = usersStatus;
      print("set state called");
      print(this.usersStatus);
    });
    print("after getting all users...");
    print(usersStatus);
    db.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (usersStatus.length > 0)
        ? new Scaffold(
            appBar: CustomToolBar(),
            bottomNavigationBar: CustomNavBar(
              selectedIndex: 0,
            ),
            drawer: CustomDrawer(),
            body: Container(
              child: Products(
                category: 'all',
              ),
            ),
          )
        : Container(
            child: Text('sorry ..!'),
          );
  }
}
