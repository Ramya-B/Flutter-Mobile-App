import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/Profile/Profile.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/components/products/products_home.dart';
import '../CustomDrawer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Your Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg1) {
        if (arg1.isEmpty || !arg1.contains('@')) {
          return 'Please enter valid email';
        }
        return null;
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Your Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg2) {
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp _regExpPwd = new RegExp(pattern);
        if (arg2.isEmpty) {
          return "Please enter password";
        } else if (!_regExpPwd.hasMatch(arg2)) {
          return "Enter Valid Password";
        }
        return null;
      },
    );

    final loginButton = Material(
        // elevation: 100,
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () {
              _formKey.currentState.validate()
                  ? Navigator.of(context).push(new MaterialPageRoute(
                     builder: (context) => new Scaffold(
                      appBar: CustomToolBar(),
                      body: Container(),
                      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                      drawer: CustomDrawer(),
                    )))
                  : Navigator.of(context);
            },
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

    final accountChecking = Container(
      alignment: Alignment.center,
      height: 50,
      child: Text('If you don \'t have account ?'),
    );

    return Scaffold(
        appBar: CustomToolBar(),
        drawer: CustomDrawer(),
        body: Form(
          key: _formKey,
          child: Center(
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
                                // SizedBox(height: 20),
                                accountChecking,
                                registerButton
                              ]))))),
        ));
  }
}
