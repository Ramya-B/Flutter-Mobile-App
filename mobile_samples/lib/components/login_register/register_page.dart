import 'package:flutter/material.dart';
import 'package:tradeleaves/components/login_register/login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Company Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Refferal Code",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new UserLogin())),
                        textColor: Colors.white,
                        color: Colors.green,
                        height: 50,
                        child: Text("Register Your Account")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
