import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/login_register/register_page.dart';
import 'package:tradeleaves/components/login_register/user_profile.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

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
                  TextField(
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
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
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
                        )
                    )
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new UserProfie())),
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 45,
                      child: Text("LOGIN")
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new RegistrationPage())),
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 45,
                      child: Text("SIGN UP")
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      // drawer: CustomDrawer(),
    );
  }
}