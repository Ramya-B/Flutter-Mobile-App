import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/models/user.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/login/LoginServiceImpl.dart';
import '../../constants.dart';
import '../../main.dart';
import '../../service_locator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  LogInServiceImpl get logInService => locator<LogInServiceImpl>();
  UserServiceImpl get userService => locator<UserServiceImpl>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  User user;
  bool autoValidate = false;

  var email;
  var password;

  verifyLogIn() async {
    print("logged in...");
    AuthRequest authRequest = AuthRequest(
        name: this.email, customerId: this.email, password: this.password);
    var authResp = await logInService.getAuthToken(authRequest);
    print("Authentication response...");
    print(authResp);
    AuthToken authToken = AuthToken.fromJson(authResp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(authToken);
    prefs.setString('token', authToken.token.toString());

    getUserInfo();
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => Home()));
  }

  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.user = User.fromJson(data);
    setState(() {
      this.user = User.fromJson(data);
      print("user response set state...");
      print(this.user);
      print(this.user.name);
      print(this.user.personalDetails.profile.person.firstName);
      prefs.setString('name',
          this.user.personalDetails.profile.person.firstName.toString());
      prefs.setString('userId', this.user.name.toString());
      print(prefs.getString('name'));
      print(prefs.getString('userId'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "yourName@company.com",
          border: InputBorder.none),
      validator: (email) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp _regExpEmail = new RegExp(pattern);
        if (email.isEmpty || email == "") {
          return "Email Can't be empty";
        } else if (!_regExpEmail.hasMatch(email)) {
          return 'Please enter valid email';
        }
        return null;
      },
      onChanged: (String userEmail) {
        setState(() {
          this.email = userEmail;
        });
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      controller: _passController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "Enter your password",
          border: InputBorder.none),
      validator: (password) {
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp _regExpPwd = new RegExp(pattern);
        if (password.isEmpty || password == "") {
          return "Password can't be empty";
        } else if (!_regExpPwd.hasMatch(password)) {
          return "Enter Valid Password";
        }
        return null;
      },
      onChanged: (String password) {
        this.password = password;
      },
    );

    final tlLogo = SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width / 2,
      child: Image.asset("assets/tllogo.png", fit: BoxFit.contain),
    );

    final loginButton = SizedBox(
      height: 30,
      child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(30),
          color: Colors.green[700],
          child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 4,
              onPressed: () {
                _formKey.currentState.validate()
                    ? verifyLogIn()
                    : Navigator.of(context);
              },
              child: Text("Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)))),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Constants.toolbarColor,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                children: <Widget>[
                  tlLogo,
                  emailField,
                  SizedBox(height: 15),
                  passwordField,
                  SizedBox(height: 15),
                  loginButton,
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Text('Forgot password?'),
                  ),
                  SizedBox(height: 20),
                  Text("Dont't have an account?"),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Register())),
                    child: Text(
                      'Click here to register',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
