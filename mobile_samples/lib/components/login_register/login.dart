import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import '../CustomBottomNavigationBar.dart';
import '../CustomDrawer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  String emailId;
  String password;

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Your Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        onChanged: (String userName) {
          this.emailId = userName;
          print("user name is " + this.emailId);
        });

    final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Your Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        onChanged: (String userPassword) {
          this.password = userPassword;
          print("user name is " + this.password);
        });

    final loginButton = Material(
        // elevation: 100,
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new CheckLogIn(
                      emailId: this.emailId,
                      passWord: this.password,
                    ))),
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

    final registerButton = Material(
        // elevation: 100,
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Register())),
            child: Text("SignUp",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

    return Scaffold(
        appBar: CustomToolBar(),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 100,
                                child: Image.asset("assets/tl.png",
                                    fit: BoxFit.contain),
                              ),
                              SizedBox(height: 20),
                              emailField,
                              SizedBox(height: 20),
                              passwordField,
                              SizedBox(height: 30),
                              loginButton,
                              SizedBox(height: 20),
                              registerButton
                            ]))))));
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
    Db db = new Db("mongodb://10.0.2.2:27017/tlapp");
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
