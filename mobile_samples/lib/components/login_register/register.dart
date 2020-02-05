import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/login_register/login.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  var fullName;
  var emailId;
  var phoneNo;
  var companyName;
  var password;
  var confirmPassword;

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    
    final nameField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String name){
        this.fullName = name;
      }
    );

    final emailField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String email){
        this.emailId = email;
      }
    );

    final phoneField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Phone Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String phone){
        this.phoneNo = phone;
      }
    );

    final companyField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Company Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String companyName){
        this.companyName = companyName;
      }
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String password){
        this.password = password;
      }
    );

    final confirmPasswordField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
      ),
      onChanged: (String confirmPassword){
        this.confirmPassword = confirmPassword;
      }
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
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SaveUser(
                          fullName: this.fullName,
                          companyName: this.companyName,
                          password: this.password,
                          emailId: this.emailId,
                          phoneNo: this.phoneNo,
                        ))),
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
                crossAxisAlignment: CrossAxisAlignment.center,
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

class SaveUser extends StatefulWidget {

  final fullName;
  final emailId;
  final phoneNo;
  final companyName;
  final password;

  SaveUser({this.fullName, this.emailId, this.phoneNo, this.companyName, this.password});
  @override
  _SaveUserState createState() => _SaveUserState();
}

class _SaveUserState extends State<SaveUser> {
  saveUser() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    coll = db.collection("users");
    coll.insert({
     "fullName" : widget.fullName,
     "emailId" : widget.emailId,
     "phoneNo" : widget.phoneNo,
     "companyName" :widget.companyName,
     "password" : widget.password
    });
    setState(() {
      print("set state called");
    });
    print("after getting all users...");
    db.close();
  }

  @override
  void initState() {
    saveUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Login(),
      ),
    );
  }
}
