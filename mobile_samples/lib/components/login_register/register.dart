import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    
    final nameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final phoneField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Phone Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final companyField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Company Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final confirmPasswordField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      )
    );

    final checkBoxField = CheckboxListTile(
      title: Text("I agree to receive SMS"),
      value: checkBoxValue,
      onChanged: (bool value){
        setState(() {
          checkBoxValue = value;
        });
      },
      controlAffinity: ListTileControlAffinity.leading
    );

    final registerButton = Material(
      // elevation: 100,
      borderRadius: BorderRadius.circular(10),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: (){},
        child: Text("Register Your Account", textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
      )
    );

    return Scaffold(
      appBar: CustomToolBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  SizedBox(height: 20),
                  emailField,
                  SizedBox(height: 20),
                  phoneField,
                  SizedBox(height: 20),
                  companyField,
                  SizedBox(height: 20),
                  passwordField,
                  SizedBox(height: 20),
                  confirmPasswordField,
                  checkBoxField,
                  SizedBox(height: 20),
                  registerButton
                ]
              )
            )
          )
        )
      )
    );
  }
}