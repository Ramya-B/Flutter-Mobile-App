import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/login/LoginServiceImpl.dart';
import '../../main.dart';
import '../../service_locator.dart';
import '../CustomDrawer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  LogInServiceImpl get logInService => locator<LogInServiceImpl>();
  UserServiceImpl get userService => locator<UserServiceImpl>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  List<Sort> sorts = [];
  final _formKey = GlobalKey<FormState>();

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
    var data = await userService.getUser();
    print("user response...");
    print(data);
    getUserProducts();
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => Home()));
  }
  

   getUserProducts() async {
    print("getUserProducts");
    ProductCriteria productCriteria = new ProductCriteria();
    Pagination pagination = new Pagination(start: 0, limit: 10);
    Sort sort = new Sort();
    sort.direction = 'desc';
    sort.sort = 'createdTime';
    this.sorts.add(sort);
    productCriteria.pagination = pagination;
    productCriteria.sort =null;
    productCriteria.siteCriterias = null;
     print("getUserProducts productCriteria");
    print(productCriteria.toJson());
    var getUserProducts = await catalogService.getUserProducts(productCriteria);
    print("getUser response...!");
    print(getUserProducts);
  }

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
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp _regExpEmail = new RegExp(pattern);
        if(arg1.isEmpty || arg1 == ""){
          return "Email Can't be empty";
        }
        else if (!_regExpEmail.hasMatch(arg1)) {
          return 'Please enter valid email';
        }
        return null;
      },
      onChanged: (String userName) {
        this.email = userName;
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
        if (arg2.isEmpty || arg2 == "") {
          return "Password can't be empty";
        } else if (!_regExpPwd.hasMatch(arg2)) {
          return "Enter Valid Password";
        }
        return null;
      },
      onChanged: (String password) {
        this.password = password;
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
                  ? verifyLogIn()
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
